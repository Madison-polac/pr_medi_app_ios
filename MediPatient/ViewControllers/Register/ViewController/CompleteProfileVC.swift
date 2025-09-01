//
//  CompleteProfileVC.swift
//  MediPatient
//
//  Created by Nick Joliya on 22/08/25.
//


import UIKit
import CountryPickerView

class CompleteProfileVC: UIViewController {

    // MARK: - Outlets (Connect these in Storyboard or Init)
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
    
    // Country picker
    private let countryPickerView = CountryPickerView()
    
    @IBOutlet weak var btnPrivacy: UIButton!
    @IBOutlet weak var btnMarketing: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
    }

    private func initialization() {
        
        btnSignUp.applyPrimaryStyle()
        
        // ISD code field as dropdown
        isdCodeField.setTitle("ISD Code")
        isdCodeField.textField.placeholder = "+1"
        isdCodeField.textField.isEnabled = false
        isdCodeField.trailingButtonType = .down
        isdCodeField.dropdownTapCallback = { [weak self] in
            self?.showISDPicker()
        }
        // Prepare left view for flag display
        isdCodeField.textField.rightViewMode = .always
        
        // Configure CountryPickerView
        countryPickerView.delegate = self
        countryPickerView.dataSource = self
        countryPickerView.showPhoneCodeInView = true
        // Set default selection
        if let current = countryPickerView.getCountryByCode(Locale.current.regionCode ?? "") ?? countryPickerView.getCountryByName("United States") {
            applyCountrySelection(current)
        }

        // Mobile phone
        mobileField.setTitle("Mobile phone")
        mobileField.textField.placeholder = "9876543210"
        mobileField.textField.keyboardType = .numberPad
        mobileField.requiredMessage = ValidationMessages.mobileNumber
        mobileField.customValidator = { text in
            guard let t = text, !t.isEmpty else { return nil }
            return ValidationHelper.isValidMobileNumber(t, minLength: 8, maxLength: 15) ? nil : ValidationMessages.validMobileNumber
        }

        // Date of Birth
        dobField.setTitle("Date of Birth")
        dobField.textField.placeholder = "12 Mar 1984"
        dobField.trailingButtonType = .calendar
        dobField.requiredMessage = ValidationMessages.dob
        dobField.calendarTapCallback = { [weak self] in
            guard let self = self else { return }
            DatePickerHelper.show(
                in: self,
                title: "Select Date of Birth",
                mode: .date,
                maximumDate: Date()
            ) { pickedDate in
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                self.dobField.textField.text = formatter.string(from: pickedDate)
                self.dobField.hideError()
            }
        }
        
        clearAllBorders()
        setSelectedBorder(for: imgMale)

    }
    
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

    
    // Helper to apply selection to ISD field
    private func applyCountrySelection(_ country: Country) {
        // Set code text first
        isdCodeField.textField.text = country.phoneCode
        // Put flag on the right side
        let imageView = UIImageView(image: country.flag)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 28, height: 20)
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 24))
        imageView.center = container.center
        container.addSubview(imageView)
        isdCodeField.textField.rightView = container
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
        case btnMale:
            setSelectedBorder(for: imgMale)
        case btnFemale:
            setSelectedBorder(for: imgFemale)
        case btnOther:
            setSelectedBorder(for: imgOther)
        default:
            break
        }
    }

    
    
    @IBAction func btnPrivacyTapped(_ sender: UIButton) {
        
        Redirect.to("TermsVC", from: self)

    }
    @IBAction func btnBackTapped(_ sender: UIButton) {
        Redirect.pop(from: self)
    }
    
    @IBAction func btnSignUpTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        // Validate using built-in field validators
        isdCodeField.validate()
        mobileField.validate()
        dobField.validate()
        let allValid = isdCodeField.errorLabel.isHidden && mobileField.errorLabel.isHidden && dobField.errorLabel.isHidden
        if allValid {
            print("All fields valid!")
        } else {
            print("Validation failed, some fields are missing!")
        }
    }

    
    // MARK: - Pickers
    private func showISDPicker() {
        countryPickerView.showCountriesList(from: self)
    }

}

// No per-field delegate needed; StaticLabelTextFieldView handles end-edit validation

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
