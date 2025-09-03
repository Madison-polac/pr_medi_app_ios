//
//  Register.swift
//  VDCSApp
//
//  Created by VM on 22/03/18.
//  Copyright © 2018 PS. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class AuthController {
    
    // MARK: - User methods
    static func getLogin (param:Dictionary<String, Any>,callback:@escaping (Bool,Any?,String,Int) -> Void) -> Void {
        ServiceManager.post(method: LOGIN, param: param, callback: { (success, response, message, statusCode) in
            let mes = message
            if (success) {
                let response = response as? [String:Any] ?? [:]
                self.convertResponsetoUserObj(response, statusCode: statusCode, message: mes, callback: callback);
            } else {
                callback(success, response, message, statusCode)
            }
        })
    }
    
    static func convertResponsetoUserObj(_ resData:[String:Any],statusCode:Int,message:String, callback:(Bool,Any?,String,Int) -> Void){
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: resData, options: .prettyPrinted)
            let jsonString = String(data: jsonData, encoding: .utf8) ?? ""
            let userObj = Mapper<User>().map(JSONString: jsonString)
            if let user = userObj {
                
                // Set access token into Global object
                //GlobalUtils.getInstance().setAccessToken(token: user.accessToken ?? "")
                callback(true,user,message,statusCode)
            } else {
                callback(false,nil,message,statusCode)
            }
        } catch {
            callback(false,nil,message,statusCode)
            print(error.localizedDescription)
        }
    }
    

    
    static func forgotPassword(param:Dictionary<String, Any>,callback:@escaping (Bool,Any?,String,Int) -> Void) -> Void {
        let emailValue: String = (param["emailId"] as? String) ?? (param["email"] as? String) ?? ""
        let encodedEmail = emailValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let methodWithQuery = "\(ForgotPassword)?emailId=\(encodedEmail)"
        ServiceManager.post(method: methodWithQuery, param: [:], callback: { (success, response, message, statusCode) in
            callback(success, response, message, statusCode)
        })
    }
    
    /*static func changePassword(param:Dictionary<String, Any>,callback:@escaping (Bool,Any?,String,Int) -> Void) -> Void {
        ServiceManager.post(method: POST_CHANGEPW, param: param, callback: { (success, response, message, statusCode) in
                callback(success, response, message, statusCode)
        })
    }
    
    static func getUserProfileInfo (param:Dictionary<String, Any>,callback:@escaping (Bool,Any?,String,Int) -> Void) -> Void {
        ServiceManager.post(method: GET_USER_PROFILE, param: param, callback: { (success, response, message, statusCode) in
            if (success) {
                do {
                    let dictRes = response as! Dictionary<String,Any>
                    let jsonData = try JSONSerialization.data(withJSONObject: dictRes, options: .prettyPrinted)
                    let jsonString = NSString(data: jsonData, encoding: String.Encoding.ascii.rawValue)
                    let userProfile = Mapper<UserProfile>().map(JSONString: jsonString! as String)
                    callback(true,userProfile,message,statusCode)
                } catch {
                    callback(false,response,message,statusCode)
                    print(error.localizedDescription)
                }
            } else {
                callback(success, response, message, statusCode)
            }
        })
    }
    
    static func saveUserProfileInfo (param:Dictionary<String, Any>,callback:@escaping (Bool,Any?,String,Int) -> Void) -> Void {
        ServiceManager.post(method: SAVE_USER_PROFILE_GENERALINFO, param: param, callback: { (success, response, message, statusCode) in
            if (success) {
                callback(true, response, message, statusCode)
            } else {
                callback(success, response, message, statusCode)
            }
        })
    }*/

}
