//
//  AppViewController.swift
//  ShortTrip
//
//  Created by prompt on 26/05/17.
//  Copyright © 2017 Prompt Softech. All rights reserved.
//

import UIKit

class AppViewController: UIViewController {
    var nededOrientation = 0
    var activityView = UIActivityIndicatorView(style: .large)
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let picker = UIPickerView()
    let container = UIView()
    var refreshControl = UIRefreshControl()
    let toolBar = UIToolbar()
    var activityIndicator = UIActivityIndicatorView()
    var societyParam:Dictionary<String,Any> = [:]
    var loadingView = LoadingView()

    // MARK: View Life Cycle Methods
    override func viewDidLoad() {
       super.viewDidLoad()
       self.createLoadingIndicatorView()
       self.navigationController?.navigationBar.isTranslucent = false
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = UIColor.barColor()
            appearance.titleTextAttributes =  [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.navTitleFont(size: 18)]
            self.navigationController?.navigationBar.standardAppearance = appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        } else {
            self.navigationController?.navigationBar.barTintColor = UIColor.barColor()
            self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white,
                  NSAttributedString.Key.font: UIFont.navTitleFont(size: 18)]
        }
       
        self.navigationController?.navigationBar.tintColor = UIColor.navTintColor
        refreshControl.tintColor = UIColor.themeColor
                
        var style = ToastStyle()
        style.messageFont = UIFont.normalFont(size: 16)
        style.messageColor = UIColor.navTintColor
        ToastManager.shared.isTapToDismissEnabled = false
        ToastManager.shared.style = style
    }
    
    func setbackButton() {
        let backBTN = UIBarButtonItem(image: UIImage.backArrow,
                                      style: .plain,
                                      target: navigationController,
                                      action: #selector(UINavigationController.popViewController(animated:)))
        navigationItem.leftBarButtonItem = backBTN
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            // SVProgressHUD.dismiss()
            LoadingOverlay.shared.hideOverlayView()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
    }
   
    //MARK: -
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        if UIDevice.current.orientation.isPortrait {
    
        } else {
            AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
        }
    }

    //---------------------------------------------------------------------
    // MARK: Round Image
    //---------------------------------------------------------------------
    func RoundImage(img: UIImageView)  {
        img.layer.cornerRadius = img.frame.size.width / 2
        img.clipsToBounds = true
    }
    
    //MARK: - Loading methods
    func createLoadingIndicatorView () {
        loadingView = LoadingView()
        loadingView.backgroundColor = .clear
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(loadingView)
        loadingView.isHidden = true
        let views = ["loadingView" : loadingView]
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[loadingView]|", options: [], metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[loadingView]|", options: [], metrics: nil, views: views))
    }
    
    func showLoading() {
        loadingView.isHidden = false
    }

    func showLoadingAlignToTop() {
        loadingView.updateCenterYMargin(margin: -80)
        loadingView.isHidden = false
    }
    
    func showBlockerLoading() {
        loadingView.updateCenterYMargin(margin: -80)
        loadingView.isHidden = false
        self.view.isUserInteractionEnabled = false
        UIApplication.shared.beginIgnoringInteractionEvents()
        loadingView.backgroundColor = UIColor(white: 1, alpha: 0.7)
    }
    
    func showLoadingForHW() {
        loadingView.updateCenterYMargin(margin: 70)
        loadingView.isHidden = false
    }
    
    func hideLoading() {
        loadingView.isHidden = true
    }
    
    func hideBlockerLoading() {
        loadingView.isHidden = true
        self.view.isUserInteractionEnabled = true
        UIApplication.shared.endIgnoringInteractionEvents()
    }
  
    // MARK: - Alert methods
    func showAlert(message: String) {
        if let view = self.navigationController?.view {
            AppHelper.showAlert(view: view, message:message)
        }
    }
    
    //MARK: - Custom Methods
    func setRefershControlString(string: String) {
        let attribute = [NSAttributedString.Key.foregroundColor: UIColor.themeColor]
        let attrString = NSAttributedString(string: string, attributes: attribute)
        self.refreshControl.attributedTitle = attrString
    }
    
    func isValidEmail(textStr: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: textStr)
    }
    
    func startAnimating() {
        self.view.isUserInteractionEnabled = false
        // SVProgressHUD.show(withStatus: "Loading")
        LoadingOverlay.shared.showOverlay(view: self.view, withTitle: "Loading")
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func startAnimatingWithIgnoringInteraction() {
        self.view.isUserInteractionEnabled = false
        UIApplication.shared.beginIgnoringInteractionEvents()
        // SVProgressHUD.show(withStatus: "Loading")
        LoadingOverlay.shared.showOverlay(view: self.view, withTitle: "Loading")
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func stopAnimating() {
        self.view.isUserInteractionEnabled = true
        // SVProgressHUD.dismiss()
        LoadingOverlay.shared.hideOverlayView()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func stopAnimatingWithIgnoringInteraction(){
        self.view.isUserInteractionEnabled = true
        UIApplication.shared.endIgnoringInteractionEvents()
        // SVProgressHUD.dismiss()
        LoadingOverlay.shared.hideOverlayView()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    // MARK : func For Navigationbar Color: ----------------------
    func navigationBarColor() {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    func didTapNavigationBarItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.menu, style: UIBarButtonItem.Style.plain, target: self, action: #selector(didTapOpenButton))
    }
    
    @objc func didTapOpenButton(_ sender: UIBarButtonItem) {
        self.dismissKeyboard()
    }
    
    
    //---------------------------------------------------------------------
    // MARK: Handle Invalid Token
    //---------------------------------------------------------------------
    func showSecurityAlert() {
        /*var main:UIStoryboard?
        if GlobalUtils.getInstance().getBundal() == BUNDLE_ID {
            main = UIStoryboard(name: MAIN_STORYBOARD, bundle: nil)
        } else {
            main = UIStoryboard(name: MAINDEV_STORYBOARD, bundle: nil)
        }
        
        let rootViewController = main?.instantiateViewController(withIdentifier: "SecurityVC")  as! SecurityVC
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.navigationBar.isTranslucent = true
        navController.setNavigationBarHidden(true, animated: false)
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        UIView.transition(with: self.view, duration: 0.1, options: .transitionCrossDissolve, animations: {
            appDelegate.window?.rootViewController = navController
            appDelegate.window?.makeKeyAndVisible()
        }, completion: { completed in })*/
        
    }
    
    func handleInvalidToken(message:String) {
        
        let alert = UIAlertController(title: "", message:"Your session has been expired, Please log in again", preferredStyle: UIAlertController.Style.alert)
        
        let action = UIAlertAction(title: "OK", style: .destructive, handler: { (action) in
            AppHelper.setifUserLoggedIn(islogin: false)
            var main:UIStoryboard?
            if GlobalUtils.getInstance().getBundal() == BUNDLE_ID {
                main = UIStoryboard(name: MAIN_STORYBOARD, bundle: nil)
            } else {
                main = UIStoryboard(name: MAINDEV_STORYBOARD, bundle: nil)
            }
       
            let rootViewController = main?.instantiateViewController(withIdentifier: "LoginVC")  as! LoginVC
            let navController = UINavigationController(rootViewController: rootViewController)
            navController.navigationBar.isTranslucent = true
            navController.setNavigationBarHidden(true, animated: false)
            let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
            //appDelegate.window?.rootViewController = navController
            //appDelegate.window?.makeKeyAndVisible()
        })
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func reutnMutableString(legth:Int,plainString:String) -> NSMutableAttributedString {
        var goalnameMutable = NSMutableAttributedString()
        goalnameMutable = NSMutableAttributedString(string: plainString as String as String, attributes: [NSAttributedString.Key.font:UIFont.normalFont(size: 16)])
        goalnameMutable.addAttribute(NSAttributedString.Key.foregroundColor, value:  UIColor.gray, range: NSRange(location:0,length:legth))
        return goalnameMutable
    }
    
    func  frequencyString(frequency:Int) -> String {
        switch frequency {
            case 0: return ""
            case 1: return "Daily"
            case 2: return "Weekly"
            case 3: return "Monthly"
            case 4: return "Quarterly"
            case 5: return "Yearly"
            default: return ""
        }
    }

    func  progressColor(value:Int) -> UIColor {
        if value >= 100 {
            return UIColor.green
        } else if value >= 85 {
            return UIColor.hexString(hex: "#FFA500")
        } else if value >= 70 {
            return UIColor.yellow
        } else {
            return UIColor.red
        }
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
        
    func getLanscape() -> Int {
        let value = UIDevice.current.orientation == .landscapeLeft ? UIInterfaceOrientation.landscapeLeft.rawValue : UIInterfaceOrientation.landscapeRight.rawValue
        return Int(value)
    }
    
    func getPortrait() -> Int {
        let value =  UIInterfaceOrientation.portraitUpsideDown.rawValue
        return Int(value)
    }
}

