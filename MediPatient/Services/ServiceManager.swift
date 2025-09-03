//
//  ServiceManager.swift


import Foundation
import UIKit
//import ObjectMapper

class ServiceManager {
    static func post(method: String, param:Dictionary<String, Any>, callback:@escaping (Bool, Any?, String, Int) -> Void) -> Void {
        var header = GlobalUtils.getInstance().getHeaderParam()
        /*if method == POST_AUTHENTICATE_USER  || method == POST_FORGOTPW || method == POST_AUTHENTICATED_USER{
            header[APP_KEY] = APPKEY_VALUE
        }*/
        let request = PSRequest(reqUrlComponent: method)
        request.reqParam = param
        request.headerParam = header
        let ws = WSHandler.sharedInstance()
        ws.post(request) { (response) in
            ServiceHelper().checkResponse(response, callback)
        }
    }
}
