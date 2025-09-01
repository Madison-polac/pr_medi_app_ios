//
//  LoginVC.swift
//  MediPatient
//
//  Created by Nick Joliya on 11/08/25.
//

import UIKit

class LoginVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var passwordField: StaticLabelTextFieldView!
    @IBOutlet weak var emailField: StaticLabelTextFieldView!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        initialization()
    }
    
    // MARK: - Initialization
    private func initialization() {
        btnSignIn.applyPrimaryStyle()
        emailField.setTitle(Constant.email)
        emailField.textField.placeholder = Constant.emailPlaceholder
        emailField.textField.keyboardType = .emailAddress
        passwordField.setTitle(Constant.password)
        passwordField.trailingButtonType = .eye
        passwordField.textField.placeholder = Constant.passwordPlaceholder
    }
    
    // MARK: - Validation and Login
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
            // Proceed with login logic
            print("All fields valid, login starts!")
        }
    }
}

// MARK: - Actions
extension LoginVC {
    @IBAction func btnSignInTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        validateAndLogin()
    }
    
    @IBAction func btnForgotPasswordTapped(_ sender: UIButton) {
        Redirect.to("ForgotPasswordVC", from: self) // push
    }
    
    @IBAction func btnCreateAcountTapped(_ sender: UIButton) {
        Redirect.to("RegisterVC", from: self) // push
    }
}
