//
//  ForgotPasswordVC.swift
//  MediPatient
//
//  Created by Nick Joliya on 22/08/25.
//

import UIKit
import MBProgressHUD

class ForgotPasswordVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tfEmail: StaticLabelTextFieldView!
    @IBOutlet weak var btnSendReset: UIButton!
 
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
    }
    
    // MARK: - Initialization
    private func initialization() {
        btnSendReset.applyPrimaryStyle()
        tfEmail.setTitle(Constant.email)
        tfEmail.textField.placeholder = Constant.emailPlaceholder
    }
    
    // MARK: - Validation
    private func validateAndSendReset() {
        var isValid = true
        let email = tfEmail.textField.text
        if ValidationHelper.isEmpty(email) {
            tfEmail.showError(Constant.emptyEmail)
            isValid = false
        } else if !ValidationHelper.isValidEmail(email) {
            tfEmail.showError(Constant.invalidEmail)
            isValid = false
        } else {
            tfEmail.hideError()
        }
        
        if isValid {
            HUD.show(on: self.view)
            sentResetLink(email: email ?? "")
        }
    }
    
    private func sentResetLink(email: String) {
        let params: Dictionary<String, Any> = ["emailId": email]
        AuthController.forgotPassword(param: params) { success, response, message, statusCode in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                HUD.hide(from: self.view)
                if success {
                    let displayMsg = message.isEmpty ? Constant.success : message
                    self.view.makeToast(displayMsg)
                } else {
                    let errorMsg = message.isEmpty ? "Something went wrong" : message
                    self.view.makeToast(errorMsg)
                }
            }
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
