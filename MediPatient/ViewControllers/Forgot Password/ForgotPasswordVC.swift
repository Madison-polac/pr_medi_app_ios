//
//  ForgotPasswordVC.swift
//  MediPatient
//
//  Created by Nick Joliya on 22/08/25.
//

import UIKit

class ForgotPasswordVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var passwordField2: StaticLabelTextFieldView!
    @IBOutlet weak var passwordField: StaticLabelTextFieldView!
    @IBOutlet weak var btnSendReset: UIButton!
 
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
    }
    
    // MARK: - Initialization
    private func initialization() {
        btnSendReset.applyPrimaryStyle()
        passwordField2.setTitle(Constant.password)
        passwordField2.textField.placeholder = Constant.passwordPlaceholder
        passwordField.setTitle(Constant.password)
        passwordField.showsEyeButton = true
        passwordField2.showsEyeButton = true
        passwordField.textField.placeholder = Constant.passwordPlaceholder
    }
    
    // MARK: - Validation and Reset
    private func validateAndSendReset() {
        let pass = passwordField2.textField.text
        if ValidationHelper.isEmpty(pass) {
            passwordField2.showError(Constant.emptyPassword)
        } else if !ValidationHelper.isValidPassword(pass) {
            passwordField2.showError(Constant.invalidPassword)
        } else {
            passwordField2.hideError()
            // Proceed with sending password reset logic
            print("Sending password reset to: \(pass ?? "")")
        }
    }
}

// MARK: - Actions
extension ForgotPasswordVC {
    @IBAction func btnSendResetTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        validateAndSendReset()
    }
    @IBAction func btnCancelTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnSignInTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: false)
    }
    
}
