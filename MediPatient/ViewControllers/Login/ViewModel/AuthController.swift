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
    static func getLogin(param: [String: Any], callback: @escaping (Bool, Any?, String, Int) -> Void) {
        ServiceManager.post(method:API.Endpoints.login, param: param) { success, response, message, statusCode in
            if success {
                let responseDict = response as? [String: Any] ?? [:]
                self.convertResponsetoUserObj(responseDict, statusCode: statusCode, message: message, callback: callback)
            } else {
                callback(success, response, message, statusCode)
            }
        }
    }
    
    static func convertResponsetoUserObj(_ resData: [String: Any], statusCode: Int, message: String, callback: (Bool, Any?, String, Int) -> Void) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: resData, options: .prettyPrinted)
            let jsonString = String(data: jsonData, encoding: .utf8) ?? ""
            let userObj = Mapper<User>().map(JSONString: jsonString)
            if let user = userObj {
                callback(true, user, message, statusCode)
            } else {
                callback(false, nil, message, statusCode)
            }
        } catch {
            callback(false, nil, message, statusCode)
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Forgot Password
    static func forgotPassword(param: [String: Any], callback: @escaping (Bool, Any?, String, Int) -> Void) {
        let emailValue: String = (param["emailId"] as? String) ?? (param["email"] as? String) ?? ""
        let encodedEmail = emailValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let methodWithQuery = "\(API.Endpoints.forgotPassword)?emailId=\(encodedEmail)"
        ServiceManager.post(method: methodWithQuery, param: [:], callback: callback)
    }
    
    // MARK: - Validate SignUP
    static func validateSignUP(param: [String: Any], callback: @escaping (Bool, Any?, String, Int) -> Void) {
        ServiceManager.post(method: API.Endpoints.validateSignUp, param: param) { success, response, message, statusCode in
            if success {
                let responseDict = response as? [String: Any] ?? [:]

                // Handle OTP required case
                if statusCode == 205 {
                    // Pass back raw data so caller can redirect to Verify OTP screen
                    callback(true, responseDict["data"], message, statusCode)
                    return
                }

                // Normal case: map to User
                self.convertResponsetoUserObj(responseDict, statusCode: statusCode, message: message, callback: callback)
            } else {
                callback(success, response, message, statusCode)
            }
        }
    }

    
    // MARK: -  SignUP
    static func signUP(param: [String: Any], callback: @escaping (Bool, Any?, String, Int) -> Void) {
        ServiceManager.post(method: API.Endpoints.signUp, param: param) { success, response, message, statusCode in
            if success {
                let responseDict = response as? [String: Any] ?? [:]
                self.convertResponsetoUserObj(responseDict, statusCode: statusCode, message: message, callback: callback)
            } else {
                callback(success, response, message, statusCode)
            }
        }
    }
    // MARK: - Verify OTP
    static func verifyOTP(param: [String: Any], callback: @escaping (Bool, Any?, String, Int) -> Void) {
        ServiceManager.post(method: API.Endpoints.verifyOtp, param: param) { success, response, message, statusCode in
            if success {
                let responseDict = response as? [String: Any] ?? [:]
                // Try mapping to User
                self.convertResponsetoUserObj(responseDict, statusCode: statusCode, message: message) { mappedSuccess, user, msg, code in
                    if mappedSuccess {
                        callback(true, user, msg, code)
                    } else {
                        // fallback: return raw dict if not full user
                        callback(true, responseDict, msg, code)
                    }
                }
            } else {
                callback(success, response, message, statusCode)
            }
        }
    }

    
    // MARK: - Resend OTP
    static func resendOTP(param: [String: Any], callback: @escaping (Bool, Any?, String, Int) -> Void) {
        ServiceManager.post(method: API.Endpoints.resendOtp, param: param) { success, response, message, statusCode in
            callback(success, response, message, statusCode)
        }
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
