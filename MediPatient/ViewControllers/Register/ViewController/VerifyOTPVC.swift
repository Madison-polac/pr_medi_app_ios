//
//  VerifyOTPVC.swift
//  MediPatient
//
//  Created by Nick Joliya on 08/09/25.
//


import UIKit

class VerifyOTPVC: UIViewController {
    
    // MARK: - Properties
    var email = ""
    private var counter = 60
    private var timer: Timer?
    
    // MARK: - Outlets
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var otpField: StaticLabelTextFieldView!
    @IBOutlet weak var btnVerify: UIButton!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var btnResend: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        startTimer()
    }
}

// MARK: - UI Setup
extension VerifyOTPVC {
    
    private func setupUI() {
        btnVerify.applyPrimaryStyle()
        btnVerify.isEnabled = false
        btnVerify.alpha = 0.5
        
        // Bold only the masked email part
        let masked = maskedEmail(email)
        let infoText = Constant.OTP.infoPrefix + masked
        let attributedInfo = NSMutableAttributedString(string: infoText)
        if let range = infoText.range(of: masked) {
            let nsRange = NSRange(range, in: infoText)
            attributedInfo.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 16), range: nsRange)
        }
        lblInfo.attributedText = attributedInfo
        
        otpField.setTitle(Constant.OTP.otpTitle)
        otpField.textField.placeholder = Constant.OTP.otpPlaceholder
        otpField.textField.keyboardType = .numberPad
        otpField.requiredMessage = Constant.OTP.otpRequiredMsg
        otpField.customValidator = { text in
            guard let t = text, !t.isEmpty else { return nil }
            return t.count == 6 ? nil : Constant.OTP.otpInvalidMsg
        }
        otpField.textChangedCallback = { [weak self] text in
            guard let self = self else { return }
            self.btnVerify.isEnabled = (text?.count == 6)
            self.btnVerify.alpha = self.btnVerify.isEnabled ? 1.0 : 0.5
        }
        
        btnResend.isHidden = true
        lblTimer.textColor = .gray
        lblTimer.font = UIFont.boldSystemFont(ofSize: 15)
    }
    
    private func maskedEmail(_ email: String) -> String {
        guard let atIndex = email.firstIndex(of: "@") else { return email }
        let prefix = email.prefix(2)
        let domain = email[atIndex...]
        return "\(prefix)******\(domain)"
    }
    
    private func startTimer() {
        counter = 30
        updateTimerLabel()
        btnResend.isHidden = true
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] t in
            guard let self = self else { return }
            if self.counter > 0 {
                self.counter -= 1
                self.updateTimerLabel()
            } else {
                t.invalidate()
                self.lblTimer.text = ""
                self.btnResend.isHidden = false
            }
        }
    }

    private func updateTimerLabel() {
        let timeText = String(format: Constant.OTP.timerText, counter)
        let attributed = NSMutableAttributedString(string: timeText)
        if let range = timeText.range(of: String(format: "%02d", counter)) {
            let nsRange = NSRange(range, in: timeText)
            attributed.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 15), range: nsRange)
        }
        lblTimer.attributedText = attributed
    }
}
//// MARK: - API
extension VerifyOTPVC {
    private func performVerifyOTP() {
        let otp = otpField.textField.text ?? ""
        
        var params: [String: Any] = GlobalUtils.getInstance().getBodyParams()
        params["email"] = email
        params["otp"] = otp
        
        HUD.show(on: view)
        AuthController.verifyOTP(param: params) { success, _, message, _ in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                HUD.hide(from: self.view)
                let displayMsg = message.isEmpty ? (success ? Constant.success : "Something went wrong") : message
                self.view.makeToast(displayMsg)
                if success {
                    Redirect.to("HomeVC", from: self) // Navigate to home or next screen
                }
            }
        }
    }
    
    private func performResendOTP() {
        var params: [String: Any] = GlobalUtils.getInstance().getBodyParams()
        params["email"] = email
        
        HUD.show(on: view)
        AuthController.resendOTP(param: params) { success, _, message, _ in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                HUD.hide(from: self.view)
                let displayMsg = message.isEmpty ? (success ? Constant.success : "Something went wrong") : message
                self.view.makeToast(displayMsg)
                if success {
                    self.startTimer()
                }
            }
        }
    }
}

// MARK: - Actions
extension VerifyOTPVC {
    @IBAction func btnVerifyTapped(_ sender: UIButton) {
        view.endEditing(true)
        otpField.validate()
        if otpField.errorLabel.isHidden {
            performVerifyOTP()
        }
    }
    
    @IBAction func btnResendTapped(_ sender: UIButton) {
        performResendOTP()
    }
    
    @IBAction func btnCancelTapped(_ sender: UIButton) {
        Redirect.pop(from: self)
    }
}
