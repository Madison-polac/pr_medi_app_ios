
import Foundation

extension Dictionary {
    func merge(_ dict: Dictionary<Key,Value>) -> Dictionary<Key,Value> {
        var mutableCopy = self
        for (key, value) in dict {
            mutableCopy[key] = value
        }
        return mutableCopy
    }
}
//---------------------------------------------------------------------
// MARK: PSRequest
//---------------------------------------------------------------------
class PSRequest: NSObject {
    
    var reqUrlComponent:String?
    var reqParam:Dictionary<String, Any> = [:]
    var reqParamArr:Array<Dictionary<String, Any>> = []
    var headerParam:Dictionary<String,String> = [:]
    
    init(reqUrlComponent:String) {
        self.reqUrlComponent = reqUrlComponent
    }
}

class PSResponse: NSObject {
    var response:URLResponse?
    var resData:Data?
    var error:Error?
    var jsonType:Int?
}

//---------------------------------------------------------------------
// MARK: WebService Handler
//---------------------------------------------------------------------
class WSHandler: NSObject,URLSessionDelegate {
    fileprivate static var obj:WSHandler?
    let kBASEURL  = BASE_URL
    let kTimeOutValue = 60
   
   let sessionToken:String? = nil
    var apiUrl:URL?
    
    static func create() -> WSHandler{
        if(obj == nil){
            obj = WSHandler()
        }
        return obj!
    }
    
    static func sharedInstance() -> WSHandler{
        if(obj == nil){
            return create()
        }
        else{
            return obj!
        }
    }
    
    //---------------------------------------------------------------------
    // MARK: appDefaultHedaer
    //---------------------------------------------------------------------
    func appDefaultHedaer() -> Dictionary<String,String>{
        let dic:Dictionary<String,String> = ["Content-Type":"application/json"]
        return dic
    }
    
    //---------------------------------------------------------------------
    // MARK: POST Web Service methods
    //---------------------------------------------------------------------
    
    func post(_ psRequest:PSRequest,completionHandler:@escaping (PSResponse?) -> Void) -> Void {
        post(psRequest,true, completionHandler: completionHandler )
    }
    
    func post(_ psRequest:PSRequest,_ isShowDialog:Bool,completionHandler:@escaping (PSResponse?) -> Void) -> Void {
        let urlComponent = psRequest.reqUrlComponent
        
        if urlComponent == nil {return}
        
        var urlSTR = ""
        
        urlSTR = kBASEURL + urlComponent!
        urlSTR = urlSTR.addingPercentEncoding(withAllowedCharacters:CharacterSet.urlQueryAllowed)!
        self.apiUrl = URL(string: urlSTR)
        var request = URLRequest(url: self.apiUrl!)
        request.httpMethod = "POST"
        request.timeoutInterval =  TimeInterval(kTimeOutValue);
        request.allHTTPHeaderFields = psRequest.headerParam

        // Set request param
        let reqParam = psRequest.reqParam
        let reqParamArray = psRequest.reqParamArr
        if (reqParam.count > 0) {
            do{
                let postData = try JSONSerialization.data(withJSONObject: reqParam, options:.prettyPrinted)
                let decoded = try JSONSerialization.jsonObject(with: postData, options: [])
                // here "decoded" is of type `Any`, decoded from JSON data
                let jsonString = String(data: postData, encoding: .utf8)
                
                print(jsonString!)

                // you can now cast it with the right type
                if decoded is [String:AnyObject] {
                    // use dictFromJSON
                }
                request.httpBody = postData
            } catch {
                let res = PSResponse()
                res.error = nil
                completionHandler(nil)
            }
        } else {
            do {
                let postData = try JSONSerialization.data(withJSONObject: reqParamArray, options:.prettyPrinted)
                let jsonString = String(data: postData, encoding: .utf8)
                print(jsonString!)
                request.httpBody = postData
            } catch {
                let res = PSResponse()
                res.error = nil
                completionHandler(nil)
            }
        }
        
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)        
        let dataTask = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            
            if data != nil{
                let datastring = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("@API: RESPONCE:\(datastring!)")
                print("\n@API: -----------------------------------------------")
            }
            
            let res = PSResponse()
            res.response = response
            
            if let resError = error {
                res.error = resError
            }
            
            if let resData = data {
                res.resData = resData
            }
             completionHandler(res)
        })
        print("@API: -----------------------------------------------\n")
        print("@API: URL:\(urlSTR)\n")
        print("@API: PARAM:\(reqParam)\n")
        
        dataTask.resume()
    }
    
    
    //---------------------------------------------------------------------
    // MARK: GET Web Service methods
    //---------------------------------------------------------------------
    
    //==============================================================
    public func makeQueryString(values: Dictionary<String,Any>) -> String {
        var querySTR = ""
        if values.count > 0 {
            querySTR = "?"
            for item in values {
                let key = item.key
                let value = item.value as! String
                let keyValue = key + "=" + value + "&"
                querySTR = querySTR.appending(keyValue)
            }
            querySTR.removeLast()
        }
        return querySTR
    }
    
    func get(_ psRequest:PSRequest,_ isShowDialog:Bool,completionHandler:@escaping (PSResponse?) -> Void) -> Void {
        
        let urlComponent = psRequest.reqUrlComponent
        
        if urlComponent == nil {return}
        
        let param = psRequest.reqParam
        let querySTR = makeQueryString(values: param)
    
        var urlSTR = kBASEURL + urlComponent! + querySTR
        
        urlSTR = urlSTR.addingPercentEncoding(withAllowedCharacters:CharacterSet.urlQueryAllowed)!
        let url = URL(string: urlSTR)
        var request = URLRequest(url: url!)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = psRequest.headerParam
        request.timeoutInterval =  180;

        
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
        let dataTask = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            
            if data != nil{
                let datastring = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("@API: RESPONCE:\(datastring!)")
                print("\n@API: -----------------------------------------------\n")
            }
            
            let res = PSResponse()
            res.response = response
            
            if let resError = error {
                res.error = resError
            }
            
            if let resData = data {
                res.resData = resData
            }
            
            //TODO: Send response back in BG thread and shift to main therad in controller only
            //DispatchQueue.main.async {
                completionHandler(res)
            //}
        })
        
        print("@API: -----------------------------------------------\n")
        print("@API: URL:\(urlSTR)\n")
        //print("@API: PARAM:\(params!)\n")
        dataTask.resume()
    }
    
    //---------------------------------------------------------------------
    // MARK: URL Session methods
    //---------------------------------------------------------------------
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            let url = URL(string: kBASEURL)
            let domain = url?.host
            if challenge.protectionSpace.host == domain {
                let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
                completionHandler(.useCredential,credential);
            }
        }
    }
}
