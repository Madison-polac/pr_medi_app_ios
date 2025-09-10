//
//  Constant.swift
//  MediPatient
//
//  Created by Nick Joliya on 21/08/25.
//

import Foundation
import UIKit

// MARK: - Base URL

    let BASE_URL = "https://securemedsoft.com/api/patients/Auth/"

//Live
//  let BASE_URL = "https://account.uat.splashtrack.com/api/"


//API
let LOGIN = "Login"
let ForgotPassword = "ForgotPassword"
let ValidateSignUp = "ValidateSignUp"
let SignUp = "SignUp"
let ResendOtp = "ResendOtp"
let VerifyOtp = "VerifyOtp"


let kAppDelegate = UIApplication.shared.delegate as! AppDelegate;
let kSecurityAlertKey = "logindate"
let WANT_TO_REFER = "wantTorefer"

let CLIENT_KEY = "5cc64b0a-1a26-48d3-8911-935624374b9a"
let CONTENT_TYPE = "Content-Type"
let CONTENTTYPE_VALUE = "application/json"
let APP_KEY = "Key"
let APPKEY_VALUE  = "WaLtuHxXSkqVQswbTcGQWg=="
let APP_VERSION = "AppVersion"
let APPVERSION_VALUE  = "1.0"
let APP_PLATFORM = "AppPlatForm"
let APP_PLATFORM_VALUE  = "4"
let APP_TYPE = "AppType"
let APPTYPE_VALUE  = "2"
let ISTOKEN_EXPIRED = "IsTokenExpired"
let ISTOKEN_EXPIRED_VALUE  = false
let CLIENT_ID = "ClientId"
let CLIENTID_VALUE  = "00000000-0000-0000-0000-000000000000"
let USER_ID = "UserId"
let DEVICE_ID = "DeviceId"
let DEVICEID_VALUE  = UIDevice.current.identifierForVendor!.uuidString
let TOKEN_ID = "TokenId"
let REQUEST_DATA = "RequestData";
let TOKEN = "token"
let USER_PREFERENCES = "UserPreferences"
let TITLE_KEY = "title"
let SUBTITLE_KEY = "subtitle"
let VALUE_KEY = "value"

let INVALID_TOKEN_CODE = 1009

let MAIN_STORYBOARD = "Main"
let MAINDEV_STORYBOARD = "Main"
let BUNDLE_ID = "com.vipulshiyal.MediPatient"

let SERVER_SHORT_DATE_FORMAT    = "yyyy-MM-dd"
let SERVER_LONG_DATE_FORMAT     = "yyyy-MM-dd'T'HH:mm:ss.SSS"
let LOGIN_DATE_FORMAT           = "yyyy-MM-dd HH:mm"
let APP_DATE_FORMAT             = "MM/dd/yyyy"
let APP_DATE_TIMEZONE_FORMAT    = "yyyy-MM-dd'T'HH:mm:ss"
let TIMZONE_Z_DATE_FORMAT       = "yyyy-MM-dd'T'HH:mm:ss'Z'"

struct Constant {

    // Email
    static let email = "Email"
    static let emailPlaceholder = "Enter your email"
    static let invalidEmail = "Invalid Email"
    static let emptyEmail = "Email required"

    // Password
    static let password = "Password"
    static let passwordPlaceholder = "Enter your password"
    static let invalidPassword = "Invalid Password"
    static let emptyPassword = "Password required"

    // First Name
    static let firstName = "First Name"
    static let firstNamePlaceholder = "First Name"
    static let invalidFirstName = "Invalid first name"
    static let emptyFirstName = "First name required"

    // Last Name
    static let lastName = "Last Name"
    static let lastNamePlaceholder = "Last Name"
    static let invalidLastName = "Invalid last name"
    static let emptyLastName = "Last name required"

    // Create a Password
    static let createPasswordPlaceholder = "Create a password"

    // Success
    static let success = "Success!"

    struct OTP {
           static let defaultEmail = "ndsgdsg@gmail.com"
           static let infoPrefix = "A 6-digit verification code has been sent to your email address "
           static let otpTitle = "Please enter the code here"
           static let otpPlaceholder = "Enter Verification Code"
           static let otpRequiredMsg = "Please enter verification code"
           static let otpInvalidMsg = "Enter 6-digit code"
           static let timerText = "Resend Code in 00:%02d"
       }
}


#if DEBUG
struct DebugCredentials {
    static let email = "jon.mac@yopmail.com"
    static let password = "Jon@1234"
    static let fname = "Luffy"
    static let lName = "Zoro"
    static let mobile  = "9797979797"
}
#endif
