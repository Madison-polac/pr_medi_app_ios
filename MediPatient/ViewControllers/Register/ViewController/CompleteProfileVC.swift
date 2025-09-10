//
//  CompleteProfileVC.swift
//  MediPatient
//
//  Created by Nick Joliya on 22/08/25.
//


import UIKit
import CountryPickerView
import RappleProgressHUD

class CompleteProfileVC: UIViewController {
    
    // MARK: - Incoming from RegisterVC
    var initialFirstName: String = ""
    var initialLastName: String = ""
    var initialEmail: String = ""
    var initialPassword: String = ""
    
    // MARK: - Outlets
    @IBOutlet weak var isdCodeField: StaticLabelTextFieldView!
    @IBOutlet weak var mobileField: StaticLabelTextFieldView!
    @IBOutlet weak var dobField: StaticLabelTextFieldView!
    @IBOutlet weak var btnSignUp: UIButton!
    
    @IBOutlet weak var imgMale: UIImageView!
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var imgFemale: UIImageView!
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak var imgOther: UIImageView!
    @IBOutlet weak var btnOther: UIButton!
    @IBOutlet weak var genderStack: UIStackView!
    
    @IBOutlet weak var btnPrivacy: UIButton!
    @IBOutlet weak var btnMarketing: UIButton!
    
    // MARK: - Properties
    private let countryPickerView = CountryPickerView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}
 
// MARK: - UI Setup
extension CompleteProfileVC {
    private func setupUI() {
        btnSignUp.applyPrimaryStyle()
        
        // ISD Code
        isdCodeField.setTitle("ISD Code")
        isdCodeField.textField.placeholder = "+1"
        isdCodeField.textField.isEnabled = false
        isdCodeField.textField.isUserInteractionEnabled = false
        isdCodeField.trailingButtonType = .down
        isdCodeField.textField.rightViewMode = .always
        isdCodeField.dropdownTapCallback = { [weak self] in self?.isdTapped() }
        isdCodeField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(isdTapped)))
        
        // Date of Birth
        dobField.setTitle("Date of Birth")
        dobField.textField.placeholder = "12 Mar 1984"
        dobField.textField.isUserInteractionEnabled = false
        dobField.trailingButtonType = .calendar
        dobField.calendarTapCallback = { [weak self] in self?.dobTapped() }
        dobField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dobTapped)))
        
        // Country Picker
        countryPickerView.delegate = self
        countryPickerView.dataSource = self
        countryPickerView.showPhoneCodeInView = true
        if let current = countryPickerView.getCountryByCode(Locale.current.regionCode ?? "")
            ?? countryPickerView.getCountryByName("United States") {
            applyCountrySelection(current)
        }
        
        // Mobile
        mobileField.setTitle("Mobile phone")
        mobileField.textField.placeholder = "9876543210"
        mobileField.textField.keyboardType = .numberPad
        mobileField.requiredMessage = ValidationMessages.mobileNumber
        mobileField.customValidator = { text in
            guard let t = text, !t.isEmpty else { return nil }
            return ValidationHelper.isValidMobileNumber(t, minLength: 8, maxLength: 15)
                ? nil : ValidationMessages.validMobileNumber
        }
        
        clearAllBorders()
        setSelectedBorder(for: imgMale)
    }
}

// MARK: - Helpers
extension CompleteProfileVC {
    private func clearAllBorders() {
        [imgMale, imgFemale, imgOther].forEach {
            $0?.layer.borderWidth = 0
            $0?.layer.borderColor = nil
        }
    }
    
    private func setSelectedBorder(for imageView: UIImageView) {
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor(hex: "#329F94")?.cgColor
        imageView.layer.cornerRadius = 24
        imageView.clipsToBounds = true
    }
    
    private func applyCountrySelection(_ country: Country) {
        isdCodeField.textField.text = country.phoneCode
        let imageView = UIImageView(image: country.flag)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 28, height: 20)
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 24))
        imageView.center = container.center
        container.addSubview(imageView)
        isdCodeField.textField.rightView = container
    }
    
    @objc private func isdTapped() {
        countryPickerView.showCountriesList(from: self)
    }
    
    @objc private func dobTapped() {
        DatePickerHelper.show(
            in: self,
            title: "Select Date of Birth",
            mode: .date,
            maximumDate: Date()
        ) { [weak self] pickedDate in
            guard let self = self else { return }
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            self.dobField.textField.text = formatter.string(from: pickedDate)
            self.dobField.hideError()
        }
    }
}

// MARK: - API
extension CompleteProfileVC {
    private func performUnifiedRegister() {
        let isdCode = isdCodeField.textField.text ?? ""
        let phone = mobileField.textField.text ?? ""
        let dobText = dobField.textField.text ?? "" // e.g. "08/09/2025"

        // ✅ Safe and clean DOB conversion using Date extension
        let formattedDOB = DateFormatter.dobFormatter.date(from: dobText)?.iso8601String ?? ""

        // Gender mapping (1=Male, 2=Female, 3=Unknown)
        let genderId: Int = imgFemale.layer.borderWidth > 0 ? 2 :
                             imgOther.layer.borderWidth > 0 ? 3 : 1

        // Build params
        var params: [String: Any] = GlobalUtils.getInstance().getBodyParams()
        params["firstName"] = initialFirstName
        params["lastName"] = initialLastName
        params["userTypeId"] = 3 // Patient
        params["email"] = initialEmail
        params["password"] = initialPassword
        params["isdCode"] = isdCode
        params["mobileNo"] = phone
        params["birthDate"] = formattedDOB
        params["genderId"] = genderId
        params["otp"] = "123456"
        params["otpCategory"] = 1 // MobileVerification
        params["roleId"] = 301 // Patient role
        params["roleIdEnc"] = ""

        RappleActivityIndicatorView.startAnimating()
        AuthController.validateSignUP(param: params) { success, data, message, statusCode in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                RappleActivityIndicatorView.stopAnimation()

                let displayMsg = message.isEmpty ? "Something went wrong" : message
                self.view.makeToast(displayMsg)

                if statusCode == 200 {
                    // Success with full user object
                    Redirect.to("HomeVC", from: self) { _ in }
                } else if statusCode == 205 {
                    Redirect.to("VerifyOTPVC", from: self) { (vc: VerifyOTPVC) in
                        vc.email = (data as? [String: Any])?["email"] as? String ?? self.initialEmail
                        vc.firstName = self.initialFirstName
                        vc.lastName = self.initialLastName
                        vc.password = self.initialPassword
                        vc.isdCode = isdCode
                        vc.mobileNo = phone
                        vc.birthDate = formattedDOB
                        vc.genderId = genderId
                        vc.roleId = 301
                        vc.roleIdEnc = ""
                        vc.userTypeId = 3
                        vc.flow = .signup
                    }
                }else {
                    print("Failed - statusCode: \(statusCode)")
                }
            }
        }
    }
}



// MARK: - Actions
extension CompleteProfileVC {
    @IBAction func checkboxTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        let imageName = sender.isSelected ? "ic_Checked" : "ic_Unchecked"
        sender.setImage(UIImage(named: imageName), for: .normal)
    }
    
    @IBAction func genderButtonTapped(_ sender: UIButton) {
        clearAllBorders()
        switch sender {
        case btnMale: setSelectedBorder(for: imgMale)
        case btnFemale: setSelectedBorder(for: imgFemale)
        case btnOther: setSelectedBorder(for: imgOther)
        default: break
        }
    }
    
    @IBAction func btnPrivacyTapped(_ sender: UIButton) {
        Redirect.to("TermsVC", from: self)
    }
    
    @IBAction func btnBackTapped(_ sender: UIButton) {
        Redirect.pop(from: self)
    }
    
    @IBAction func btnSignUpTapped(_ sender: UIButton) {
        view.endEditing(true)
        isdCodeField.validate()
        mobileField.validate()
        dobField.validate()
        
        let allValid = isdCodeField.errorLabel.isHidden
                    && mobileField.errorLabel.isHidden
                    && dobField.errorLabel.isHidden
        
        // ✅ New condition: check if privacy and marketing checkboxes are ticked
        let privacyAccepted = btnPrivacy.isSelected
        let marketingAccepted = btnMarketing.isSelected
        
        if allValid && privacyAccepted && marketingAccepted {
            performUnifiedRegister()
//            Redirect.to("VerifyOTPVC", from: self) { (vc: VerifyOTPVC) in
//                vc.email = self.initialEmail
//            }
        } else {
            if !privacyAccepted {
                view.makeToast("Please accept Privacy Policy")
            } else if !marketingAccepted {
                view.makeToast("Please accept Marketing Policy")
            } else {
                view.makeToast("Validation failed, some fields are missing!")
            }
            print("Validation failed - checkboxes not selected or fields missing")
        }
    }
}

// MARK: - CountryPickerViewDelegate & DataSource
extension CompleteProfileVC: CountryPickerViewDelegate, CountryPickerViewDataSource {
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        applyCountrySelection(country)
        isdCodeField.hideError()
    }
    
    func navigationTitle(in countryPickerView: CountryPickerView) -> String? {
        return "Select Country"
    }
    
    func showPhoneCodeInList(in countryPickerView: CountryPickerView) -> Bool {
        return true
    }
}
