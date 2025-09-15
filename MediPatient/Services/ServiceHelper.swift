//
//  ServiceHelper.swift

import Foundation


class ServiceHelper {
    func checkResponse(_ response: PSResponse?, _ callback:(Bool, Any?, String, Int) -> Void) {
        var success = true
        let error = response?.error
        if (error != nil ) {
            let msg = error?.localizedDescription ?? "The operation couldn't be completed, because of service error"
            callback(false, nil, msg, 0)
        }
        
        let resData = response?.resData
        if resData != nil {
            do {
                if let res = response?.response {
                    let httpResponse = res as? HTTPURLResponse
                    let contentType = httpResponse?.allHeaderFields["Content-Type"] as? String
                    
                    if contentType == "text/html; charset=utf-8" {
                        let datastring = NSString(data: resData!, encoding: String.Encoding.utf8.rawValue)
                        if (datastring?.contains("Unauthorized"))! {
                            // Go to login page
                            callback(false, nil, AppHelper.localizedtext(key: "login.inactivity.alert"), AppConfig.invalidTokenCode)
                        }
                    }
                }
                
                /*
                    Check if we are getting unauthorise HTML page, if YES then redirect to login page.
                */
                
                
                let dic:Dictionary<String, Any> = try JSONSerialization.jsonObject(with: resData!, options: JSONSerialization.ReadingOptions.allowFragments) as! Dictionary<String, Any>
                if dic["data"] == nil {
                    success = false
                }
                
                if dic["statusCode"] == nil {
                    let dic:Dictionary<String, Any> = [:]
                    callback(false, dic, "No method found", 0)
                    return
                }
                
                let statusCode = dic["statusCode"] as! Int
                var message = ""
                if dic["message"] != nil {
                    message = dic["message"] as! String
                }
                
                let data = dic["data"]
                if statusCode == 200 || statusCode == 1 {
                    callback(success, data, message, statusCode)
                } else {
                    callback(false, data, message, statusCode)
                }
            } catch {
                let raw = response?.resData.flatMap { String(data: $0, encoding: .utf8) } ?? "No Data Found"
                callback(false, nil, raw, 0)
            }
        }
    }
}
