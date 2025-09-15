//
//  LoginVC.swift
//  MediPatient
//
//  Created by Nick Joliya on 11/08/25.
//

import UIKit
//import MBProgressHUD
import RappleProgressHUD

class LoginVC: AppViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var passwordField: StaticLabelTextFieldView!
    @IBOutlet weak var emailField: StaticLabelTextFieldView!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupUI()
    }
}

// MARK: - UI Setup
extension LoginVC {
    private func setupUI() {
        btnSignIn.applyPrimaryStyle()
        
        emailField.setTitle(Constant.Email.label)
        emailField.textField.placeholder = Constant.Email.placeholder
        emailField.textField.keyboardType = .emailAddress
        
        passwordField.setTitle(Constant.Password.label)
        passwordField.trailingButtonType = .eye
        passwordField.textField.placeholder = Constant.Password.placeholder
        
        #if DEBUG
        emailField.textField.text = DebugCredentials.email
        passwordField.textField.text = DebugCredentials.password
        #endif
    }
}

// MARK: - Validation
extension LoginVC {
    private func validateAndLogin() {
        var isValid = true
        
        // Email
        let email = emailField.textField.text
        if ValidationHelper.isEmpty(email) {
            emailField.showError(Constant.Email.empty)
            isValid = false
        } else if !ValidationHelper.isValidEmail(email) {
            emailField.showError(Constant.Email.invalid)
            isValid = false
        } else {
            emailField.hideError()
        }
        
        // Password
        let password = passwordField.textField.text
        if ValidationHelper.isEmpty(password) {
            passwordField.showError(Constant.Password.empty)
            isValid = false
        } else if !ValidationHelper.isValidPassword(password) {
            passwordField.showError(Constant.Password.invalid)
            isValid = false
        } else {
            passwordField.hideError()
        }
        
        if isValid {
            doLogin(username: email ?? "", password: password ?? "")
        }
    }
}

// MARK: - API Calls
extension LoginVC {
    func doLogin(username: String, password: String) {
        var params: [String: Any] = GlobalUtils.getInstance().getBodyParams()
        params["userName"] = username
        params["password"] = password
        params["appleId"] = ""
        params["isFromMobile"] = true

        RappleActivityIndicatorView.startAnimating()
        AuthController.getLogin(param: params) { [weak self] success, response, message, statusCode in
            DispatchQueue.main.async {
                guard let self = self else { return }
                RappleActivityIndicatorView.stopAnimation()
                
                let displayMsg = message.isEmpty ? "Something went wrong" : message
                self.view.makeToast(displayMsg)

                if statusCode == 205, let userObj = response as? User {
                    // ✅ Login success
                    print("Login successful for: \(userObj.userName)")
                    Redirect.to("HomeVC", from: self) { _ in }
                    
                } else if statusCode == 200 {
                    Redirect.to("VerifyOTPVC", from: self) { (vc: VerifyOTPVC) in
                        vc.email = username
                        vc.flow = .login
                        if let data = response as? [String: Any], let patientIdEnc = data["patientIdEnc"] as? String {
                            vc.patientIdEnc = patientIdEnc
                        }
                        // Or, if you have a User instance:
                        if let user = response as? User {
                            vc.patientIdEnc = user.patientIdEnc ?? ""
                        }
                    }
                }
 else {
                    // ❌ Invalid login
                    let fallbackMsg = LocalizedString(message: "login.invalidUP.alert")
                    let errorMsg = message.isEmpty ? fallbackMsg : message
                    self.view.makeToast(errorMsg)
                    print("Login failed - statusCode: \(statusCode)")
                }
            }
        }
    }

}

// MARK: - Actions
extension LoginVC {
    @IBAction func btnSignInTapped(_ sender: UIButton) {
        view.endEditing(true)
        validateAndLogin()
    }
    
    @IBAction func btnForgotPasswordTapped(_ sender: UIButton) {
        Redirect.to("ForgotPasswordVC", from: self)
    }
    
    @IBAction func btnCreateAcountTapped(_ sender: UIButton) {
        Redirect.to("RegisterVC", from: self)
    }
}

