//
//  RegisterVC.swift
//  MediPatient
//
//  Created by Nick Joliya on 22/08/25.
//

import UIKit

class RegisterVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var firstNameField: StaticLabelTextFieldView!
    @IBOutlet weak var lastNameField: StaticLabelTextFieldView!
    @IBOutlet weak var emailField: StaticLabelTextFieldView!
    @IBOutlet weak var passwordField: StaticLabelTextFieldView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
    }

    // MARK: - Initialization
    private func initialization() {
       
        btnContinue.applyPrimaryStyle()
        
        firstNameField.setTitle(Constant.firstName)
        firstNameField.textField.placeholder = Constant.firstName
        
        lastNameField.setTitle(Constant.lastName)
        lastNameField.textField.placeholder = Constant.lastName
        
        emailField.setTitle(Constant.email)
        emailField.textField.placeholder = Constant.emailPlaceholder
        
        passwordField.setTitle(Constant.password)
        passwordField.textField.placeholder = Constant.createPasswordPlaceholder
        passwordField.trailingButtonType = .eye
    }

    // MARK: - Validation & Registration
    private func validateAndRegister() {
        var isValid = true

        // First Name
        let firstName = firstNameField.textField.text
        if ValidationHelper.isEmpty(firstName) {
            firstNameField.showError(Constant.emptyFirstName)
            isValid = false
        } else if !ValidationHelper.isValidName(firstName) {
            firstNameField.showError(Constant.invalidFirstName)
            isValid = false
        } else {
            firstNameField.hideError()
        }

        // Last Name (optional, but you can enforce if you wish)
        let lastName = lastNameField.textField.text
        if ValidationHelper.isEmpty(lastName) {
            lastNameField.showError(Constant.lastName)
            isValid = false
        } else if !ValidationHelper.isValidName(lastName) {
            lastNameField.showError(Constant.invalidLastName)
            isValid = false
        } else {
            lastNameField.hideError()
        }

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

        // Proceed with registration if all is valid
        if isValid {
            print("All fields valid, register user!")
            // Add your registration API call or logic here
        }
    }
}

// MARK: - Actions
extension RegisterVC {
    
    @IBAction func btnContinueTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        validateAndRegister()
        let vc =  self.storyboard?.instantiateViewController(identifier: "CompleteProfileVC") as! CompleteProfileVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnSignInTapped(_ sender: UIButton) {
        // Navigate to Sign In screen (pop or push)
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func btnCancelTapped(_ sender: UIButton) {
        // Dismiss or pop
        self.navigationController?.popViewController(animated: true)
    }
}
