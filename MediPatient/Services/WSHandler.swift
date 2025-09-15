
import Foundation

// MARK: - Dictionary Merge
extension Dictionary {
    func merge(_ dict: Dictionary<Key, Value>) -> Dictionary<Key, Value> {
        var mutableCopy = self
        for (key, value) in dict {
            mutableCopy[key] = value
        }
        return mutableCopy
    }
}

// MARK: - API Status Codes
enum APIStatusCode: Int {
    case success = 200
    case error = 201
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case conflictError = 409
    case internalServerError = 500
    case serviceUnavailable = 503
    case unknown = -1
    
    var defaultMessage: String {
        switch self {
        case .success: return "✅ Success"
        case .error: return "❌ Invalid user credentials."
        case .badRequest: return "❌ Bad request."
        case .unauthorized: return "❌ Unauthorized."
        case .forbidden: return "❌ Forbidden."
        case .notFound: return "❌ Not found."
        case .conflictError: return "❌ Conflict."
        case .internalServerError: return "❌ Internal server error."
        case .serviceUnavailable: return "❌ Service unavailable."
        case .unknown: return "❌ Unknown error."
        }
    }
}

//---------------------------------------------------------------------
// MARK: - PSRequest
//---------------------------------------------------------------------
class PSRequest: NSObject {
    var reqUrlComponent: String?
    var reqParam: [String: Any] = [:]
    var reqParamArr: [[String: Any]] = []
    var headerParam: [String: String] = [:]
    
    init(reqUrlComponent: String) {
        self.reqUrlComponent = reqUrlComponent
    }
}

//---------------------------------------------------------------------
// MARK: - PSResponse
//---------------------------------------------------------------------
class PSResponse: NSObject {
    var response: URLResponse?
    var resData: Data?
    var error: Error?
    
    var statusCode: Int = -1
    var message: String = ""
    var dataDict: [String: Any]?
    
    func parse() {
        guard let resData = resData else { return }
        do {
            if let json = try JSONSerialization.jsonObject(with: resData, options: []) as? [String: Any] {
                self.statusCode = json["statusCode"] as? Int ?? -1
                self.message = json["message"] as? String ?? ""
                self.dataDict = json["data"] as? [String: Any]
            }
        } catch {
            print("⚠️ JSON Parse Error: \(error.localizedDescription)")
        }
    }
    
    func readableMessage() -> String {
        if let code = APIStatusCode(rawValue: statusCode) {
            return message.isEmpty ? code.defaultMessage : message
        }
        return message.isEmpty ? APIStatusCode.unknown.defaultMessage : message
    }
}

//---------------------------------------------------------------------
// MARK: - WSHandler
//---------------------------------------------------------------------
class WSHandler: NSObject, URLSessionDelegate {
    fileprivate static var obj: WSHandler?
    let kBASEURL = API.baseURL
    let kTimeOutValue = 60
    
    var apiUrl: URL?
    
    // Singleton
    static func sharedInstance() -> WSHandler {
        if obj == nil { obj = WSHandler() }
        return obj!
    }
    
    //---------------------------------------------------------------------
    // MARK: Headers
    //---------------------------------------------------------------------
    func appDefaultHeader() -> [String: String] {
        ["Content-Type": "application/json"]
    }
    
    //---------------------------------------------------------------------
    // MARK: POST
    //---------------------------------------------------------------------
    func post(_ psRequest: PSRequest, completionHandler: @escaping (PSResponse?) -> Void) {
        guard let urlComponent = psRequest.reqUrlComponent else { return }
        
        let urlSTR = (kBASEURL + urlComponent).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        self.apiUrl = URL(string: urlSTR)
        
        var request = URLRequest(url: self.apiUrl!)
        request.httpMethod = "POST"
        request.timeoutInterval = TimeInterval(kTimeOutValue)
        request.allHTTPHeaderFields = psRequest.headerParam.isEmpty ? appDefaultHeader() : psRequest.headerParam
        
        // Set body
        do {
            let bodyData: Data
            if psRequest.reqParam.count > 0 {
                bodyData = try JSONSerialization.data(withJSONObject: psRequest.reqParam, options: [])
            } else {
                bodyData = try JSONSerialization.data(withJSONObject: psRequest.reqParamArr, options: [])
            }
            request.httpBody = bodyData
            print("📤 PARAM: \(String(data: bodyData, encoding: .utf8) ?? "")")
        } catch {
            print("⚠️ Request JSON Encoding Error: \(error.localizedDescription)")
        }
        
        logRequest(request)
        
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        let dataTask = session.dataTask(with: request) { data, response, error in
            let res = PSResponse()
            res.response = response
            res.error = error
            res.resData = data
            res.parse()
            
            self.logResponse(res)
            
            completionHandler(res)
        }
        dataTask.resume()
    }
    
    //---------------------------------------------------------------------
    // MARK: GET
    //---------------------------------------------------------------------
    func get(_ psRequest: PSRequest, completionHandler: @escaping (PSResponse?) -> Void) {
        guard let urlComponent = psRequest.reqUrlComponent else { return }
        
        let querySTR = makeQueryString(values: psRequest.reqParam)
        let urlSTR = (kBASEURL + urlComponent + querySTR).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = URL(string: urlSTR)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.timeoutInterval = TimeInterval(kTimeOutValue)
        request.allHTTPHeaderFields = psRequest.headerParam.isEmpty ? appDefaultHeader() : psRequest.headerParam
        
        logRequest(request)
        
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        let dataTask = session.dataTask(with: request) { data, response, error in
            let res = PSResponse()
            res.response = response
            res.error = error
            res.resData = data
            res.parse()
            
            self.logResponse(res)
            
            completionHandler(res)
        }
        dataTask.resume()
    }
    
    //---------------------------------------------------------------------
    // MARK: Helper
    //---------------------------------------------------------------------
    private func logRequest(_ request: URLRequest) {
        print("\n🌍 API REQUEST --------------------------------")
        print("URL: \(request.url?.absoluteString ?? "")")
        print("METHOD: \(request.httpMethod ?? "")")
        print("HEADERS: \(request.allHTTPHeaderFields ?? [:])")
    }
    
    private func logResponse(_ res: PSResponse) {
        print("\n📩 API RESPONSE -------------------------------")
        
        if let httpRes = res.response as? HTTPURLResponse {
            print("STATUS: \(httpRes.statusCode)")
        }
        
        if let error = res.error {
            print("❌ ERROR: \(error.localizedDescription)")
        } else if let data = res.resData {
            let jsonStr = String(data: data, encoding: .utf8) ?? ""
            print("BODY: \(jsonStr)")
        }
        
        print("MESSAGE: \(res.readableMessage())")
        print("------------------------------------------------\n")
    }
    
    func makeQueryString(values: [String: Any]) -> String {
        guard !values.isEmpty else { return "" }
        return "?" + values.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
    }
    
    //---------------------------------------------------------------------
    // MARK: SSL Pinning (Optional)
    //---------------------------------------------------------------------
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            let url = URL(string: kBASEURL)
            let domain = url?.host
            if challenge.protectionSpace.host == domain {
                if let trust = challenge.protectionSpace.serverTrust {
                    let credential = URLCredential(trust: trust)
                    completionHandler(.useCredential, credential)
                    return
                }
            }
        }
        completionHandler(.performDefaultHandling, nil)
    }
}
