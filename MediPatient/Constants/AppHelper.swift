//
//  AppHelper.swift
//  ShortTrip
//
//  Created by prompt on 26/05/17.
//  Copyright © 2017 Prompt Softech. All rights reserved.
//

import UIKit
import SystemConfiguration
import LocalAuthentication
import Photos

enum LAError : Int {
    case AuthenticationFailed
    case UserCancel
    case UserFallback
    case SystemCancel
    case PasscodeNotSet
    case TouchIDNotAvailable
    case TouchIDNotEnrolled
}

class AppHelper: NSObject {
    
    static func biometricAuthentication(callBack: @escaping(Bool?, String?) -> Void) {
        let context: LAContext = LAContext()
        // Declare a NSError variable.
        let myLocalizedReasonString = LocalizedString(message: "login.authenticationRequired.alert")
        var authError: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authError) {
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: myLocalizedReasonString) { success, evaluateError in
                var message = ""
                if let error = authError {
                    message = self.showErrorMessageForLAErrorCode(errorCode: error.code)
                }
                callBack(success, message)
            }
        }
    }
    
    static func showErrorMessageForLAErrorCode( errorCode:Int ) -> String {
        var message = ""
        switch errorCode {
            case LAError.AuthenticationFailed.rawValue:
                message = LocalizedString(message: "login.authenticationFailed.alert")
            case LAError.PasscodeNotSet.rawValue:
                message = LocalizedString(message: "login.passcodeNotSet.alert")
            case LAError.SystemCancel.rawValue:
                message = LocalizedString(message: "login.authenticationCancelled.alert")
            case LAError.TouchIDNotAvailable.rawValue:
                message = LocalizedString(message: "login.touchIdNotAvailable.alert")
            case LAError.UserCancel.rawValue:
                message = LocalizedString(message: "login.userCancel.alert")
            case LAError.UserFallback.rawValue:
                message = LocalizedString(message: "login.fallback.alert")
            default:
                message = ""
        }
        return message
    }

    static func localizedtext(key:String) -> String {
        return NSLocalizedString(key, comment: "")
    }
    
    // MARK: - Storyboard methods
    static var isSplashTrack: Bool {
        return (GlobalUtils.getInstance().getBundal() == AppConfig.bundleId)
    }
    
    static var mainStoryboard: UIStoryboard {
        if isSplashTrack {
            return UIStoryboard(name: AppConfig.mainStoryboard, bundle: nil)
        } else {
            return UIStoryboard(name: AppConfig.mainDevStoryboard, bundle: nil)
        }
    }
    
    
    // MARK: - Set and Get Login methods
    static func setifUserLoggedIn(islogin: Bool) -> Void {
        UserDefaults.standard.set(islogin, forKey: "userLoggedIn")
        UserDefaults.standard.synchronize()
    }
    
    static func userLoggedIn() -> Bool {
        let userLoggedIn = UserDefaults.standard.bool(forKey: "userLoggedIn")
        return userLoggedIn
    }
    
    static func isValidPasswordFormat(textStr: String) -> Bool {
        let pwRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,15}"
        let pwTest = NSPredicate(format:"SELF MATCHES %@", pwRegEx)
        return pwTest.evaluate(with: textStr)
    }
    
    // MARK: - NoRecord View methods
    static func createNoRecordView(superView : UIView?, message : String?, imageName : String?) -> UIView {
        let view = self.createNoRecordView(superView: superView, message: message, imageName: imageName, topMargin: -20)
        return view
    }
 
    static func createNoRecordView(superView : UIView?, message : String?, imageName : String?, topMargin: CGFloat) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clear
        view.isHidden = true
        superView?.addSubview(view)
        
        // Add constraints to superview
        superView?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: ["view" : view]))
        superView?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: [], metrics: nil, views: ["view" : view]))
        
        // Create subviews
        let imageView = UIImageView(image: UIImage.init(named: imageName ?? ""))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0.7
        view.addSubview(imageView)
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        label.text = message
        label.textAlignment = .center
        label.font = UIFont.normalFont(size: 14)
        label.textColor = UIColor.darkGray
        label.numberOfLines = 0
        
        let views = ["imageView" : imageView, "label" : label]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[imageView(40)]", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[imageView(40)]", options: [], metrics: nil, views: views))
        
        view.addConstraint(NSLayoutConstraint.init(item: imageView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint.init(item: label, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0))
        
        // vertical constraints
        view.addConstraint(NSLayoutConstraint.init(item: label, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: topMargin))
        
        view.addConstraint(NSLayoutConstraint.init(item: imageView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: label, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: -50))
        
        return view
    }
    
    // MARK: - Alert methods
    static func showAlertWithAction(vc: AppViewController, title: String?, message: String, okAction: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: LocalizedString(message: "action.ok.text"), style: .default, handler: {(UIAlertAction) in
            okAction()
        })
        alert.addAction(okayAction)
        vc.present(alert, animated: true, completion: nil)
    }
        
    static func showAlert(view: UIView, message:String) {
        if message != "" {
            view.makeToast(message)
        }
    }

    static func showSettingsAlert(vc: AppViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: LocalizedString(message: "action.ok.text"), style: .default, handler: nil)
        let settingsAction = UIAlertAction(title: LocalizedString(message: "action.settings.text"), style: .default) { (action) in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, options: [:], completionHandler: { (success) in
                    
                })
            }
        }
        alert.addAction(okayAction)
        alert.addAction(settingsAction)
        vc.present(alert, animated: true, completion: nil)
    }
    
    
    
    static func trendImage(value: Int) -> UIImage {
        switch value {
            case 1: return UIImage.trendUpArrow
            case 2: return UIImage.trendDownArrow
            case 3: return UIImage.trendMaintain
            default: return UIImage()
        }
    }
    
    //---------------------------------------------------------------------
    // MARK: Check Internet Connected or Not
    //---------------------------------------------------------------------
    static func isInternetConnected() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let isConnected = (isReachable && !needsConnection)
        if !isConnected {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate            
            AppHelper.showAlert(view: appDelegate.window ?? UIWindow(), message: LocalizedString(message: "internet.alert"))
        }
        return isConnected
    }
    
}



struct AppUtility {
    
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }
    
    /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
        
        self.lockOrientation(orientation)
        
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
    }
    
    static func checkPhotoLibraryPermission() {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized: break
        //handle authorized status
        case .denied, .restricted :
            
            let alert = UIAlertController(title: "", message: AppHelper.localizedtext(key: "access.permission.alert"), preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: AppHelper.localizedtext(key: "action.cancel.text"), style: .default, handler: {(UIAlertAction) in
            })
            alert.addAction(cancelAction)
            
            let settingAction = UIAlertAction(title: AppHelper.localizedtext(key: "action.appsettings.text"), style: .default, handler: {(UIAlertAction) in
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            })
            alert.addAction(settingAction)
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            break
        case .notDetermined:
            // ask for permissions
            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                case .authorized: break
                // as above
                case .denied, .restricted: break
                // as above
                case .notDetermined: break
                // won't happen but still
                default: break
                }
            }
        default: break
        }
    }
}
