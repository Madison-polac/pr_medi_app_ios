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
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnForgotPassword: UIButton!
    
    
    
  
    // MARK: - Properties
    private var isPasswordVisible = false
    
    @IBOutlet weak var passwordField: StaticLabelTextFieldView!
    @IBOutlet weak var emailField: StaticLabelTextFieldView!
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //initialization()
        
        emailField.setTitle("Email")
        emailField.textField.placeholder = "Enter your email"
        passwordField.setTitle("Password")
        //passwordField.textField.isSecureTextEntry = true
        passwordField.showsEyeButton = true
        passwordField.textField.placeholder = "Enter your password"
    }
    
    // MARK: - Initialization
    private func initialization() {
        btnSignUp.applySignUpStyle()
        btnLogin.layer.cornerRadius = 8
        btnForgotPassword.underlineTitle(color: .systemBlue)
        
    }
}


// MARK: - Actions
extension LoginVC {
    
    @IBAction func btnLoginTapped(_ sender: UIButton) {
        self.view.endEditing(true)
       // validateAndLogin()
    }
    
    @IBAction func btnSignUpTapped(_ sender: UIButton) {
        print("Sign Up button tapped!")
    }
    
  
}

// MARK: - Custom Methods
//extension LoginVC {
//    
////    private func validateAndLogin() {
////        let email = tfUserName.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
////        let pass = tfPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
////
////        guard !email.isEmpty else {
////            showAlert(message: "Please enter your email.")
////            return
////        }
////        guard ValidationHelper.isValidEmail(email) else {
////            showAlert(message: "Please enter a valid email address.")
////            return
////        }
////        guard !pass.isEmpty else {
////            showAlert(message: "Please enter your Password.")
////            return
////        }
////        guard ValidationHelper.isValidPassword(pass, minLength: 6) else {
////            showAlert(message: "Password must be at least 6 characters long.")
////            return
////        }
//
//        // Passed all validations
//        btnLogin.isEnabled = false
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            self.btnLogin.isEnabled = true
//            self.showAlert(title: "Success", message: "Logged in successfully!")
//        }
//    }
//
//    
//    private func showAlert(title: String = "Alert", message: String) {
//        let alert = UIAlertController(title: title,
//                                      message: message,
//                                      preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK",
//                                      style: .default))
//        present(alert, animated: true)
//    }
//}
//
