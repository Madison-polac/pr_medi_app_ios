//
//  Constant.swift
//  MediPatient
//
//  Created by Nick Joliya on 21/08/25.
//

import Foundation
import UIKit

// MARK: - API Configuration
struct API {
    static let baseURL = "https://securemedsoft.com/api/patients/Auth/"
    // Live
    // static let baseURL = "https://account.uat.splashtrack.com/api/"
    
    struct Endpoints {
        static let login = "Login"
        static let forgotPassword = "ForgotPassword"
        static let validateSignUp = "ValidateSignUp"
        static let signUp = "SignUp"
        static let resendOtp = "ResendOtp"
        static let verifyOtp = "VerifyOtp"
    }
}

// MARK: - Headers & Keys
struct APIHeaders {
    static let clientKey       = "5cc64b0a-1a26-48d3-8911-935624374b9a"
    static let contentType     = "Content-Type"
    static let contentTypeVal  = "application/json"
    static let appKey          = "Key"
    static let appKeyVal       = "WaLtuHxXSkqVQswbTcGQWg=="
    static let appVersion      = "AppVersion"
    static let appVersionVal   = "1.0"
    static let appPlatform     = "AppPlatForm"
    static let appPlatformVal  = "4"
    static let appType         = "AppType"
    static let appTypeVal      = "2"
    static let isTokenExpired  = "IsTokenExpired"
    static let clientId        = "ClientId"
    static let clientIdVal     = "00000000-0000-0000-0000-000000000000"
    static let userId          = "UserId"
    static let deviceId        = "DeviceId"
    static let deviceIdVal     = UIDevice.current.identifierForVendor?.uuidString ?? ""
    static let tokenId         = "TokenId"
    static let requestData     = "RequestData"
    static let token           = "token"
}

// MARK: - App Config
struct AppConfig {
    static let bundleId = "com.vipulshiyal.MediPatient"
    static let mainStoryboard = "Main"
    static let mainDevStoryboard = "Main"
    static let invalidTokenCode = 1009
    
    // Keys
    static let kSecurityAlertKey = "logindate"
    static let wantToRefer = "wantTorefer"
    static let userPreferences = "UserPreferences"
    static let titleKey = "title"
    static let subtitleKey = "subtitle"
    static let valueKey = "value"
    
    // Date Formats
    struct DateFormat {
        static let serverShort = "yyyy-MM-dd"
        static let serverLong = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        static let loginDate = "yyyy-MM-dd HH:mm"
        static let appDate = "MM/dd/yyyy"
        static let appDateTimeZone = "yyyy-MM-dd'T'HH:mm:ss"
        static let timeZoneZ = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    }
}

// MARK: - Constants (UI / Messages)
struct Constant {
    // Email
    struct Email {
        static let label = "Email"
        static let placeholder = "Enter your email"
        static let invalid = "Invalid Email"
        static let empty = "Email required"
    }
    
    // Password
    struct Password {
        static let label = "Password"
        static let placeholder = "Enter your password"
        static let invalid = "Invalid Password"
        static let empty = "Password required"
    }
    
    // First Name
    struct FirstName {
        static let label = "First Name"
        static let placeholder = "First Name"
        static let invalid = "Invalid first name"
        static let empty = "First name required"
    }
    
    // Last Name
    struct LastName {
        static let label = "Last Name"
        static let placeholder = "Last Name"
        static let invalid = "Invalid last name"
        static let empty = "Last name required"
    }
    
    // General
    static let createPasswordPlaceholder = "Create a password"
    static let success = "Success!"
    
    // OTP
    struct OTP {
        static let defaultEmail = "ndsgdsg@gmail.com"
        static let infoPrefix = "A 6-digit verification code has been sent to your email address "
        static let title = "Please enter the code here"
        static let placeholder = "Enter Verification Code"
        static let requiredMsg = "Please enter verification code"
        static let invalidMsg = "Enter 6-digit code"
        static let timerText = "Resend Code in 00:%02d"
    }
}

// MARK: - Debug Credentials (only DEBUG build)
#if DEBUG
struct DebugCredentials {
    static let email = "vipulshiyalmca@gmail.com"
    static let password = "123456"
    static let fname = "Luffy"
    static let lName = "Zoro"
    static let mobile = "9797979797"
}
#endif

// MARK: - App Delegate Shortcut
let kAppDelegate = UIApplication.shared.delegate as! AppDelegate
