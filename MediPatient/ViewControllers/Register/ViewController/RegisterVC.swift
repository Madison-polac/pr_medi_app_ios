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
        setupUI()
    }
}

// MARK: - UI Setup
private extension RegisterVC {
    func setupUI() {
        btnContinue.applyPrimaryStyle()
        
        firstNameField.setTitle(Constant.firstName)
        firstNameField.textField.placeholder = Constant.firstName
        
        lastNameField.setTitle(Constant.lastName)
        lastNameField.textField.placeholder = Constant.lastName
        
        emailField.setTitle(Constant.email)
        emailField.textField.placeholder = Constant.emailPlaceholder
        emailField.textField.keyboardType = .emailAddress
        
        passwordField.setTitle(Constant.password)
        passwordField.textField.placeholder = Constant.createPasswordPlaceholder
        passwordField.trailingButtonType = .eye
        
        #if DEBUG
        passwordField.textField.text = "123456"
        #endif
    }
}

// MARK: - Validation & Navigation
private extension RegisterVC {
    func validateAndRegister() {
        var isValid = true
        
        // First Name
        let firstName = firstNameField.textField.text
        if ValidationHelper.isEmpty(firstName) {
            firstNameField.showError(Constant.emptyFirstName)
            isValid = false
        } else {
            firstNameField.hideError()
        }
        
        // Last Name
        let lastName = lastNameField.textField.text
        if ValidationHelper.isEmpty(lastName) {
            lastNameField.showError(Constant.lastName)
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
        
        // Navigation
        if isValid {
            navigateToCompleteProfile(
                firstName: firstName ?? "",
                lastName: lastName ?? "",
                email: email ?? "",
                password: password ?? ""
            )
        }
    }
    
    func navigateToCompleteProfile(firstName: String, lastName: String, email: String, password: String) {
        guard let vc = storyboard?.instantiateViewController(identifier: "CompleteProfileVC") as? CompleteProfileVC else { return }
        vc.initialFirstName = firstName
        vc.initialLastName = lastName
        vc.initialEmail = email
        vc.initialPassword = password
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Actions
extension RegisterVC {
    @IBAction func btnContinueTapped(_ sender: UIButton) {
        view.endEditing(true)
        validateAndRegister()
    }
    
    @IBAction func btnSignInTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: false)
    }
    
    @IBAction func btnCancelTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
