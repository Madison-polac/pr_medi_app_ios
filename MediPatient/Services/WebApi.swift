import Foundation
import UIKit
//import ObjectMapper

class WebApi {
    
    static let sharedInstance:WebApi = {
        let instance = WebApi()
        return instance
    }()
    
    fileprivate func getDefaultErrorMsg() -> String{
        return NSLocalizedString("ERROR_MSG_1", comment: "")
    }
    
    fileprivate func getInternateErrorMsg() -> String{
        return NSLocalizedString("ERROR_MSG_INTERNET", comment: "")
    }
    
    fileprivate func callBackError(_ error:Error) -> Void{
        print(getDefaultErrorMsg())
    }
    
    
    func doLogin(urlComponent:String,param:Dictionary<String, Any>,header:Dictionary<String,String>, callback:@escaping (Bool,Any?,String,Int) -> Void) -> Void {
        
        let request = PSRequest(reqUrlComponent: urlComponent)
        request.reqParam = param
        request.headerParam = header
        let ws = WSHandler.sharedInstance()
        ws.post(request) { (response) in
            self.checkResponse(response, callback)
        }
        
    }
    
    
    func selectClientApi(urlComponent:String,param:Dictionary<String, Any>,header:Dictionary<String,String>, callback:@escaping (Bool,Any?,String,Int) -> Void) -> Void {
        
        let request = PSRequest(reqUrlComponent: urlComponent)
        request.reqParam = param
        request.headerParam = header
        let ws = WSHandler.sharedInstance()
        ws.post(request) { (response) in
            self.checkResponse(response, callback)
        }
        
    }
    
    //---------------------------------------------------------------------
    // MARK: Check Response
    //---------------------------------------------------------------------
    func checkResponse(_ response:PSResponse?,_ callback:(Bool,Any?,String,Int) -> Void){
        
        // stage 1
        let error = response?.error
        if (error != nil ){
            callback(false,nil,"Something went wrong",0)
        }
        
        // stage 2
        let resData = response?.resData
        if resData != nil {
            
            do {
                let dic:Dictionary<String,Any> = try JSONSerialization.jsonObject(with: resData!, options: JSONSerialization.ReadingOptions.allowFragments) as! Dictionary<String,Any>

               //let token = GlobalUtils.getInstance().sessionToken()
                
                if dic["statusCode"] == nil {
                    let dic:Dictionary<String, Any> = [:]
                    callback(false,dic,"No method found",0)
                    return
                }
                let statusCode = dic["statusCode"] as! Int
                
                var message = ""
                if dic["message"] != nil {
                    message = dic["message"] as! String
                }
                let data = dic["data"]
                    if statusCode == 200 || statusCode == 1 {
                        let response = data as? [String:Any] ?? [:]
                        callback(true,response,message,statusCode)
                       
                    }
                    else {
                        
                    }
            } catch {
                callback(false,nil,"No Data Found",0)
            }
        }
    }
    
    
    
    
  
    
    }

