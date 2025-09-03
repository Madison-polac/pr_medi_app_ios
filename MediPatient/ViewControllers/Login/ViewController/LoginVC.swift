//
//  LoginVC.swift
//  MediPatient
//
//  Created by Nick Joliya on 11/08/25.
//

import UIKit
import MBProgressHUD

class LoginVC: UIViewController {
    
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
        
        emailField.setTitle(Constant.email)
        emailField.textField.placeholder = Constant.emailPlaceholder
        emailField.textField.keyboardType = .emailAddress
        
        passwordField.setTitle(Constant.password)
        passwordField.trailingButtonType = .eye
        passwordField.textField.placeholder = Constant.passwordPlaceholder
        
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
            emailField.showError(Constant.emptyEmail)
            isValid = false
        } else if !ValidationHelper.isValidEmail(email) {
            emailField.showError(Constant.invalidEmail)
            isValid = false
        } else {
            emailField.hideError()
        }
        
        // Password
        let password = passwordField.textField.text
        if ValidationHelper.isEmpty(password) {
            passwordField.showError(Constant.emptyPassword)
            isValid = false
        } else if !ValidationHelper.isValidPassword(password) {
            passwordField.showError(Constant.invalidPassword)
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

        HUD.show(on: view)
        AuthController.getLogin(param: params) { [weak self] success, response, message, statusCode in
            DispatchQueue.main.async {
                guard let self = self else { return }
                HUD.hide(from: self.view)
                
                if success, let userObj = response as? User {
                    print("Login successful for: \(userObj.userName)")
                } else {
                    let fallbackMsg = LocalizedString(message: "login.invalidUP.alert")
                    let displayMsg = message.isEmpty ? fallbackMsg : message
                    self.view.makeToast(displayMsg)
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

