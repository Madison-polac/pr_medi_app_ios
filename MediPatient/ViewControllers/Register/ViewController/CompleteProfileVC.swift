//
//  CompleteProfileVC.swift
//  MediPatient
//
//  Created by Nick Joliya on 22/08/25.
//


import UIKit

class CompleteProfileVC: UIViewController {

    // MARK: - Outlets (Connect these in Storyboard or Init)
    @IBOutlet weak var isdCodeField: StaticLabelTextFieldView!
    @IBOutlet weak var mobileField: StaticLabelTextFieldView!
    @IBOutlet weak var dobField: StaticLabelTextFieldView!
    @IBOutlet weak var sexField: StaticLabelTextFieldView!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
    }

    private func initialization() {
        
        btnSignUp.applyPrimaryStyle()
        
        // ISD code field as dropdown
        isdCodeField.setTitle("ISD Code")
        isdCodeField.textField.placeholder = "+1"
        isdCodeField.trailingButtonType = .dropdown
        isdCodeField.dropdownTapCallback = { [weak self] in
            self?.showISDPicker()
        }

        // Mobile phone
        mobileField.setTitle("Mobile phone")
        mobileField.textField.placeholder = "9876543210"
        mobileField.textField.keyboardType = .numberPad

        // Date of Birth
        dobField.setTitle("Date of Birth")
        dobField.textField.placeholder = "12 Mar 1984"
        dobField.trailingButtonType = .calendar
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
            }
        }


        // Birth Sex as dropdown
        sexField.setTitle("Birth Sex")
        sexField.textField.placeholder = "Select"
        sexField.trailingButtonType = .dropdown
        sexField.dropdownTapCallback = { [weak self] in
            self?.genderStack.isHidden.toggle()
        }
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
    private func validateFields() -> Bool {
        var isValid = true
        
        // ISD Code
        if let isdText = isdCodeField.textField.text, isdText.isEmpty {
            isdCodeField.showError("ISD code required")
            isValid = false
        } else {
            isdCodeField.hideError()
        }
        
        // Mobile Phone
        if let mobileText = mobileField.textField.text, mobileText.isEmpty {
            mobileField.showError("Mobile number required")
            isValid = false
        } else {
            mobileField.hideError()
        }
        
        // Date of Birth
        if let dobText = dobField.textField.text, dobText.isEmpty {
            dobField.showError("Date of birth required")
            isValid = false
        } else {
            dobField.hideError()
        }
        
        // Birth Sex
        if let sexText = sexField.textField.text, sexText.isEmpty {
            sexField.showError("Birth sex required")
            isValid = false
        } else {
            sexField.hideError()
        }

        return isValid
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
            sexField.textField.text = "Male"
        case btnFemale:
            setSelectedBorder(for: imgFemale)
            sexField.textField.text = "Female"
        case btnOther:
            setSelectedBorder(for: imgOther)
            sexField.textField.text = "Prefer not to say"
        default:
            break
        }
    }


    
    @IBAction func btnPrivacyTapped(_ sender: UIButton) {
        let vc =  self.storyboard?.instantiateViewController(identifier: "TermsVC") as! TermsVC
        self.navigationController?.pushViewController(vc, animated: true)

    }
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSignUpTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        if validateFields() {
            // Proceed with registration logic here
            print("All fields valid!")
        } else {
            print("Validation failed, some fields are missing!")
        }
    }

    
    // MARK: - Pickers
    private func showISDPicker() {
        // Show ISD picker logic
        print("Show ISD Picker")
    }

}
