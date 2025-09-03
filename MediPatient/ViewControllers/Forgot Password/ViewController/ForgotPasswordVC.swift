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
        setupUI()
    }
}

// MARK: - UI Setup
private extension ForgotPasswordVC {
    func setupUI() {
        btnSendReset.applyPrimaryStyle()
        tfEmail.setTitle(Constant.email)
        tfEmail.textField.placeholder = Constant.emailPlaceholder
    }
}

// MARK: - Validation & API
private extension ForgotPasswordVC {
    func validateAndSendReset() {
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
            HUD.show(on: view)
            sendResetLink(email: email ?? "")
        }
    }
    
    func sendResetLink(email: String) {
        let params: [String: Any] = ["emailId": email]
        
        AuthController.forgotPassword(param: params) { success, _, message, _ in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                HUD.hide(from: self.view)
                
                let displayMsg = message.isEmpty
                    ? (success ? Constant.success : "Something went wrong")
                    : message
                
                self.view.makeToast(displayMsg)
            }
        }
    }
}

// MARK: - Actions
extension ForgotPasswordVC {
    @IBAction func btnSendResetTapped(_ sender: UIButton) {
        view.endEditing(true)
        validateAndSendReset()
    }
    
    @IBAction func btnCancelTapped(_ sender: UIButton) {
        view.endEditing(true)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSignInTapped(_ sender: UIButton) {
        view.endEditing(true)
        navigationController?.popViewController(animated: false)
    }
}
