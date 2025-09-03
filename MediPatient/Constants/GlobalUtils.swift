//
//  Global Utility.swift
//  ShortTrip
//
//  Created by Abhishek Yadav on 17/05/17.
//  Copyright © 2017 Prompt Softech. All rights reserved.84
//

import Foundation
import UIKit

class GlobalUtils {
    
    fileprivate static var globalUtils:GlobalUtils?
    
    init() {
    }
    
    //---------------------------------------------------------------------
    // MARK: Create
    //---------------------------------------------------------------------
    static func create() -> GlobalUtils{
        if(GlobalUtils.globalUtils == nil){
            GlobalUtils.globalUtils = GlobalUtils()
        }
        return GlobalUtils.globalUtils!
    }
    
    //---------------------------------------------------------------------
    // MARK: Get Instance
    //---------------------------------------------------------------------
    static func getInstance() -> GlobalUtils{
        if(GlobalUtils.globalUtils == nil){
            GlobalUtils.globalUtils = GlobalUtils.create()
        }
        return GlobalUtils.globalUtils!
    }
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    //---------------------------------------------------------------------
    // MARK: Access Token
    //---------------------------------------------------------------------
    /*
      UPDATE: 26 Oct 2020, UpdateBy: Mehul Patel
     */
    func accessToken() -> String {
        var token = UserDefaults.standard.value(forKey: "accessToken")
        if token == nil {
            token = ""
        }
        return token as! String
    }
    
    func setAccessToken(token: String)  {
        UserDefaults.standard.set(token, forKey: "accessToken")
        UserDefaults.standard.synchronize()
    }
    
    //---------------------------------------------------------------------
    // MARK: Set and Get Email
    //---------------------------------------------------------------------
    
    func setCurrentIdentifire(strBundalIdentifire:String) -> Void {
        UserDefaults.standard.set(strBundalIdentifire, forKey: "bundal")
        UserDefaults.standard.synchronize()
    }
    
    func getBundal() -> String {
        var strBudal = UserDefaults.standard.value(forKey: "bundal")
        if strBudal == nil {
            strBudal = ""
        }
        return strBudal as! String
    }

    func setRememberMe(isremember:Bool,strUser:String) -> Void {
        UserDefaults.standard.set(strUser, forKey: "userText")
        UserDefaults.standard.set(isremember, forKey: "isremember")
        UserDefaults.standard.synchronize()
    }
    
    func getRememberMe() -> Bool{
        let isremeber = UserDefaults.standard.value(forKey: "isremember")
        if isremeber != nil {
            return isremeber as! Bool
        }
        return false
    }
    func userText() -> String {
        var user = UserDefaults.standard.value(forKey: "userText")
        if user == nil {
            user = ""
        }
        return user as! String
    }
    
    
    
    func setEmail(email:String) -> Void {
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.synchronize()
    }
    
    func setWantToRefer(firstname:String,lastname:String,email:String,phone:String)-> Void {
        let dict:Dictionary = ["firstname":firstname,"lastname":lastname,"email":email,"phone":phone]
        UserDefaults.standard.set(dict, forKey: WANT_TO_REFER)
        UserDefaults.standard.synchronize()
    }
    
    func getWantToRefer() -> Dictionary<String, String>  {
        let dict:Dictionary = UserDefaults.standard.value(forKey: WANT_TO_REFER) as! Dictionary<String, String>
        return dict
    }
    
    func removeWantToRefer() {
        UserDefaults.standard.removeObject(forKey: WANT_TO_REFER)
    }
    
    func email() -> String {
        var userName = UserDefaults.standard.value(forKey: "email")
        if userName == nil {
            userName = ""
        }
        return userName as! String
    }
    
    
    func setClientJobTitleId(ClientJobTitleId:String) -> Void {
        UserDefaults.standard.set(ClientJobTitleId, forKey: "ClientJobTitleId")
        UserDefaults.standard.synchronize()
    }
    
    func getClientJobTitleId() -> String {
        var ClientJobTitleId = UserDefaults.standard.value(forKey: "ClientJobTitleId")
        if ClientJobTitleId == nil {
            ClientJobTitleId = ""
        }
        return ClientJobTitleId as! String
    }
    
    func username() -> String {
        var userName = UserDefaults.standard.value(forKey: "username")
        if userName == nil {
            userName = ""
        }
        return userName as! String
    }
    
    
    func setUserName(username:String) -> Void {
        UserDefaults.standard.set(username, forKey: "username")
        UserDefaults.standard.synchronize()
    }
    
    
    func password() -> String {
        var password = UserDefaults.standard.value(forKey: "password")
        if password == nil {
            password = ""
        }
        return password as! String
    }
    
    
    
    
    func setPassword(password:String) -> Void {
        UserDefaults.standard.set(password, forKey: "password")
        UserDefaults.standard.synchronize()
    }
    
    func designation() -> String {
        var userName = UserDefaults.standard.value(forKey: "JobTitleName")
        if userName == nil {
            userName = ""
        }
        return userName as! String
    }
    
    func setDesignation(designation:String) -> Void {
        UserDefaults.standard.set(designation, forKey: "JobTitleName")
        UserDefaults.standard.synchronize()
    }
    
    func clientID() -> String {
        var clientID = UserDefaults.standard.value(forKey: "clientID")
        if clientID == nil {
            clientID = ""
        }
        return clientID as! String
    }
    
    func setClientID(clientId:String)  {
        UserDefaults.standard.set(clientId, forKey: "clientID")
        UserDefaults.standard.synchronize()
    }
    
    
    func setUserDetailID(userDetailID:String) -> Void {
        UserDefaults.standard.set(userDetailID, forKey: "userDetailID")
        UserDefaults.standard.synchronize()
    }
    
    func userDetailID() -> String {
        var userID = UserDefaults.standard.value(forKey: "userDetailID")
        if userID == nil {
            userID = ""
        }
        return userID as! String
    }
    
    
    func setUserID(userID:String) -> Void {
        UserDefaults.standard.set(userID, forKey: "userID")
        UserDefaults.standard.synchronize()
    }
    
    func userID() -> String {
        var userID = UserDefaults.standard.value(forKey: "userID")
        if userID == nil {
            userID = ""
        }
        return userID as! String
    }
    
    func isActive() -> Bool {
        var isActive = UserDefaults.standard.value(forKey: "IsActive")
        if isActive == nil {
            isActive = true
        }
        return isActive as! Bool
    }
    
    func setIsActive(isActive: Bool) -> Void {
        UserDefaults.standard.set(isActive, forKey: "IsActive")
        UserDefaults.standard.synchronize()
    }
    
    //---------------------------------------------------------
    // MARK: Set and Get Session Token
    //---------------------------------------------------------
    
    func setSessionToken(token:String) -> Void {
        UserDefaults.standard.set(token, forKey: "token")
        UserDefaults.standard.synchronize()
    }
    
    func sessionToken() -> String {
        var sessionToken = UserDefaults.standard.value(forKey: "token")
        if sessionToken == nil {
            sessionToken = ""
        }
        return sessionToken as! String
    }
    
    
    func setDeviceToken(token:String) -> Void {
        UserDefaults.standard.set(token, forKey: "devicetoken")
        UserDefaults.standard.synchronize()
    }
    
    func getDeviceToken() -> String {
        var sessionToken = UserDefaults.standard.value(forKey: "devicetoken")
        if sessionToken == nil {
            sessionToken = ""
        }
        return sessionToken as! String
    }
    
    
    // Mark: set and get API Secret and API Key ---------------------------
  
    
    
    func setApiKey(ApiKey:String) -> Void {
        UserDefaults.standard.set(ApiKey, forKey: "ApiKey")
        UserDefaults.standard.synchronize()
    }
    
    func ApiKey() -> String {
        var ApiKey = UserDefaults.standard.value(forKey: "ApiKey")
        if ApiKey == nil {
            ApiKey = ""
        }
        return ApiKey as! String
    }
    
    func setAPISecret(APISecret:String) -> Void {
        UserDefaults.standard.set(APISecret, forKey: "APISecret")
        UserDefaults.standard.synchronize()
    }
    
    func APISecret() -> String {
        var APISecret = UserDefaults.standard.value(forKey: "APISecret")
        if APISecret == nil{
            APISecret = ""
        }
        return APISecret as! String
    }
    
    
    //---------------------------------------------------------------------
    // MARK: Headers
    //---------------------------------------------------------------------
    
    func getHeaderParam() -> Dictionary<String,String> {
            var headerParam =  [CONTENT_TYPE: CONTENTTYPE_VALUE]
            headerParam["accept"] = "text/plain"
            
            let apiSecret = GlobalUtils.getInstance().APISecret()
            let userId = GlobalUtils.getInstance().userDetailID()
            let clientID = GlobalUtils.getInstance().clientID()
            
            if clientID.count > 0 {
                let hmac = Utility.generateBase64ForClientIdAndUserId(userId: userId, apiSecretKey: apiSecret, clientId: clientID)
                print("\nHmac: " + hmac)

                headerParam ["CustomAuth"] = hmac
            }
        
            let accessToken = GlobalUtils.getInstance().accessToken()
            if accessToken.count > 0 {
                let authorizationHeader = String("Bearer \(accessToken)")
                headerParam ["Authorization"] = authorizationHeader
                print("Header: " + authorizationHeader)
            }

            return headerParam
        }
    
    func getBodyParams() -> Dictionary<String,Any> {
        var params : Dictionary<String,Any> = [:]
//        params[APP_KEY] = APPKEY_VALUE
//        params[APP_VERSION] = APPVERSION_VALUE
        params[APP_PLATFORM] = APP_PLATFORM_VALUE
        params[APP_TYPE] = APPTYPE_VALUE
        params[DEVICE_ID] = DEVICEID_VALUE
        return params
    }
    
    
    //MARK:- StartDate & EndDate
    func GetDays() -> Int {
        return UserDefaults.standard.value(forKey: "days") as? Int ?? 30
    }
    func setAppStartDate(dateStart:String) -> Void {
        UserDefaults.standard.set(dateStart, forKey: "startDate")
        UserDefaults.standard.synchronize()
    }
    func setAppEndDate(dateEnd:String) -> Void {
        UserDefaults.standard.set(dateEnd, forKey: "EndDate")
        UserDefaults.standard.synchronize()
    }
    func getStartDate() -> String {
        return UserDefaults.standard.value(forKey: "startDate") as! String
    }
    func getEndDate() -> String {
        return UserDefaults.standard.value(forKey: "EndDate") as! String
    }
    
    func setLoginDateTime(datelogind:Date) -> Void {
        UserDefaults.standard.set(datelogind, forKey: kSecurityAlertKey)
        UserDefaults.standard.synchronize()
    }
    func getLoginDateTime() -> Date {
        return UserDefaults.standard.value(forKey: kSecurityAlertKey) as! Date
    }
    func setLogoutAlert(islogout:Bool) -> Void {
        UserDefaults.standard.set(islogout, forKey: "securityLogout")
        UserDefaults.standard.synchronize()
    }
    func getLogoutAlert() -> Bool {
        return UserDefaults.standard.value(forKey: "securityLogout") as! Bool
    }
    
}

