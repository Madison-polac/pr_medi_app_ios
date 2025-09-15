//
//  VerifyOTPVC.swift
//  MediPatient
//
//  Created by Nick Joliya on 08/09/25.
//
enum OTPFlow {
    case login
    case signup
}

import UIKit
import RappleProgressHUD

class VerifyOTPVC: UIViewController {
    
    // MARK: - Properties
    var email = ""
    private var counter = 60
    private var timer: Timer?
    var flow: OTPFlow = .signup
    var patientIdEnc: String = ""
    // 👇 individual fields needed for SignUp API
        var firstName: String = ""
        var lastName: String = ""
        var password: String = ""
        var isdCode: String = ""
        var mobileNo: String = ""
        var birthDate: String = ""   // ISO8601 string
        var genderId: Int = 1
        var roleId: Int = 301
        var roleIdEnc: String = ""
        var userTypeId: Int = 3
    
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
        
        otpField.setTitle(Constant.OTP.title)
        otpField.textField.placeholder = Constant.OTP.placeholder
        otpField.textField.keyboardType = .numberPad
        otpField.requiredMessage = Constant.OTP.requiredMsg
        otpField.customValidator = { text in
            guard let t = text, !t.isEmpty else { return nil }
            return t.count == 6 ? nil : Constant.OTP.invalidMsg
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

// MARK: - API
extension VerifyOTPVC {
    private func performVerifyOTP() {
        let otp = otpField.textField.text ?? ""
        
        RappleActivityIndicatorView.startAnimating()
        
        switch flow {
        case .login:
            var params: [String: Any] = GlobalUtils.getInstance().getBodyParams()
            params["userIdEnc"] = patientIdEnc // TODO: set if backend gives this in login response
            params["mobileNumber"] = "" // TODO: pass phone if verifying mobile
            params["email"] = email
            params["otp"] = ""
            params["otpCategory"] = 1 // MobileVerification (or 2 if TwoStepLogin)
            params["loginIfMatch"] = true
            
            AuthController.verifyOTP(param: params) { success, _, message, _ in
                self.handleOTPResponse(success: success, message: message)
            }

            
        case .signup:
            var params: [String: Any] = GlobalUtils.getInstance().getBodyParams()
            params["firstName"] = firstName
            params["lastName"] = lastName
            params["userTypeId"] = userTypeId
            params["email"] = email
            params["password"] = password
            params["isdCode"] = isdCode
            params["mobileNo"] = mobileNo
            params["birthDate"] = birthDate
            params["genderId"] = genderId
            params["otp"] = otp
            params["roleId"] = roleId
            params["roleIdEnc"] = roleIdEnc
            
            AuthController.signUP(param: params) { success, _, message, _ in
                self.handleOTPResponse(success: success, message: message)
            }
        }
    }

    private func performResendOTP() {
        var params: [String: Any] = GlobalUtils.getInstance().getBodyParams()
        params["email"] = email
        
        RappleActivityIndicatorView.startAnimating()
        AuthController.resendOTP(param: params) { success, _, message, _ in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                RappleActivityIndicatorView.stopAnimation()
                let displayMsg = message.isEmpty ? (success ? Constant.success : "Something went wrong") : message
                self.view.makeToast(displayMsg)
                if success {
                    self.startTimer()
                }
            }
        }
    }
    
    private func handleOTPResponse(success: Bool, message: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            RappleActivityIndicatorView.stopAnimation()
            let displayMsg = message.isEmpty ? (success ? Constant.success : "Something went wrong") : message
            self.view.makeToast(displayMsg)
            if success {
                Redirect.to("HomeVC", from: self)
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
