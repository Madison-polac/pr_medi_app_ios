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
        
        firstNameField.setTitle(Constant.FirstName.label)
        firstNameField.textField.placeholder = Constant.FirstName.placeholder
        
        lastNameField.setTitle(Constant.LastName.label)
        lastNameField.textField.placeholder = Constant.LastName.placeholder
        
        emailField.setTitle(Constant.Email.label)
        emailField.textField.placeholder = Constant.Email.placeholder
        emailField.textField.keyboardType = .emailAddress
        
        passwordField.setTitle(Constant.Password.label)
        passwordField.textField.placeholder = Constant.createPasswordPlaceholder
        passwordField.trailingButtonType = .eye
        
       
    }
}

// MARK: - Validation & Navigation
private extension RegisterVC {
    func validateAndRegister() {
        var isValid = true
        
        // First Name
        let firstName = firstNameField.textField.text ?? ""
        if ValidationHelper.isEmpty(firstName) {
            firstNameField.showError(Constant.FirstName.empty)
            isValid = false
        } else {
            firstNameField.hideError()
        }
        
        // Last Name
        let lastName = lastNameField.textField.text ?? ""
        if ValidationHelper.isEmpty(lastName) {
            lastNameField.showError(Constant.LastName.empty)
            isValid = false
        } else {
            lastNameField.hideError()
        }
        
        // Email
        let email = emailField.textField.text ?? ""
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
        let password = passwordField.textField.text ?? ""
        if ValidationHelper.isEmpty(password) {
            passwordField.showError(Constant.Password.empty)
            isValid = false
        } else if !ValidationHelper.isValidPassword(password) {
            passwordField.showError(Constant.Password.invalid)
            isValid = false
        } else {
            passwordField.hideError()
        }
        
        // Navigation
        if isValid {
            navigateToCompleteProfile(
                firstName: firstName,
                lastName: lastName,
                email: email,
                password: password
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
