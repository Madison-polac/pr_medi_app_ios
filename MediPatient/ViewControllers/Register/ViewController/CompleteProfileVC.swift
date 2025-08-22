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
    @IBOutlet weak var marketingSwitch: UISwitch!
    @IBOutlet weak var consentSwitch: UISwitch!
    @IBOutlet weak var privacyButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupFields()
       // setupActions()
    }

    private func setupFields() {
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
        dobField.textField.placeholder = "Mar 12, 1984"
        dobField.trailingButtonType = .calendar
        dobField.calendarTapCallback = { [weak self] in
            self?.showDatePicker()
        }

        // Birth Sex as dropdown
        sexField.setTitle("Birth Sex")
        sexField.textField.placeholder = "Select"
        sexField.trailingButtonType = .dropdown
        sexField.dropdownTapCallback = { [weak self] in
            self?.showSexPicker()
        }
    }

    private func setupActions() {
        privacyButton.addTarget(self, action: #selector(privacyButtonTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }

    // MARK: - Actions
    @objc private func privacyButtonTapped() {
        // Show Privacy Policy / Terms logic
        print("Privacy button tapped")
    }

    @objc private func signUpButtonTapped() {
        self.view.endEditing(true)
        // Perform validation and registration
        print("Sign up button tapped")
    }

    // MARK: - Pickers
    private func showISDPicker() {
        // Show ISD picker logic
        print("Show ISD Picker")
    }

    private func showDatePicker() {
        // Show Date Picker logic
        print("Show Date Picker")
    }

    private func showSexPicker() {
        // Show Birth Sex Picker logic
        print("Show Sex Picker")
    }
}
