//
//  CompleteProfileVC.swift
//  MediPatient
//
//  Created by Nick Joliya on 22/08/25.
//


import UIKit

class CompleteProfileVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var isdField: ISDCodePickerView!
    @IBOutlet weak var mobileField: StaticLabelTextFieldView!
    @IBOutlet weak var dobField: DatePickerTextFieldView!
    @IBOutlet weak var sexDropdown: DropdownTextFieldView! // For birth sex dropdown
    @IBOutlet weak var sexSelectionStack: UIStackView! // Contains image+label buttons for Male/Female/Prefer not to say
    
    @IBOutlet weak var marketingSwitch: UISwitch!
    @IBOutlet weak var marketingLabel: UILabel!
    
    @IBOutlet weak var consentSwitch: UISwitch!
    @IBOutlet weak var consentLabel: UILabel!
    @IBOutlet weak var privacyButton: UIButton!
    
    @IBOutlet weak var btnSignUp: UIButton!
    
    // MARK: - Properties
    var selectedSex: String?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        
        // ISD Code Picker (Custom drop, e.g., "+1 🇺🇸")
        isdField.setTitle("ISD Code")
        isdField.textField.placeholder = "+1"
        
        // Mobile number
        mobileField.setTitle("Mobile phone")
        mobileField.textField.placeholder = "9876543210"
        mobileField.textField.keyboardType = .numberPad
        
        // Date of Birth Picker
        dobField.setTitle("Date of Birth")
        dobField.textField.placeholder = "Mar 12, 1984"
        
        // Sex as dropdown AND horizontal selection - sync selected value
        sexDropdown.setTitle("Birth Sex")
        sexDropdown.textField.placeholder = "Select"
        sexDropdown.options = ["Male", "Female", "Prefer not to say"]
        sexDropdown.didSelectOption = { [weak self] option in
            self?.setSelectedSex(option)
        }

        // Optionally: set up horizontal avatar/sex buttons
        setupSexSelectionStack()
        
        // Marketing consent
        marketingLabel.text = "I would like to receive marketing communication from Medi regarding its products, services and events"
        marketingLabel.font = UIFont.ubuntuRegular(ofSize: 14)
        
        // Terms consent
        consentLabel.text = "I have read and agree to the"
        consentLabel.font = UIFont.ubuntuRegular(ofSize: 14)

        let privacyTitle = NSMutableAttributedString(string: "Privacy Policy, Terms & Condition")
        privacyTitle.addAttribute(.foregroundColor, value: AppThemeColors.PrimaryButtonColor, range: NSRange(location: 0, length: privacyTitle.length))
        privacyButton.setAttributedTitle(privacyTitle, for: .normal)
        privacyButton.titleLabel?.font = UIFont.ubuntuRegular(ofSize: 14)
        privacyButton.backgroundColor = .clear
        
        // Primary Button
        btnSignUp.setTitle("Sign up", for: .normal)
        btnSignUp.applyPrimaryStyle()
    }
    
    // MARK: - Sex Selection (Image + Label)
    private func setupSexSelectionStack() {
        // Your stackView in storyboard contains 3 buttons each with image+label
        // Assign tags or actions to buttons for Male, Female, Prefer not to say
        for (index, view) in sexSelectionStack.arrangedSubviews.enumerated() {
            if let button = view as? UIButton {
                button.addTarget(self, action: #selector(handleSexSelection(_:)), for: .touchUpInside)
                button.tag = index // 0: Male, 1: Female, 2: Prefer not to say
            }
        }
    }
    
    @objc func handleSexSelection(_ sender: UIButton) {
        let options = ["Male", "Female", "Prefer not to say"]
        guard sender.tag < options.count else { return }
        let selected = options[sender.tag]
        setSelectedSex(selected)
        sexDropdown.textField.text = selected
        // Optionally highlight selected button visually
    }

    private func setSelectedSex(_ sex: String) {
        selectedSex = sex
        sexDropdown.textField.text = sex
        // Optionally update UI for avatar selection
    }
    
    // MARK: - Actions
    @IBAction func btnSignUpTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        // Validate fields as you did for registration step 1
        // - ISD code, mobile, dob, birth sex, consentSwitch.isOn
        // Show errors as needed using showError(_:) for each field
        // If all valid:
        print("Profile completed, sign up logic here!")
    }
    
    @IBAction func privacyButtonTapped(_ sender: UIButton) {
        // Show Privacy Policy / Terms
    }
}
