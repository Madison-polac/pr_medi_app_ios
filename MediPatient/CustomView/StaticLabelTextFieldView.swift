//
//  StaticLabelTextFieldView.swift
//  MediPatient
//
//  Created by Nick Joliya on 21/08/25.
//

import UIKit

// MARK: - Trailing Button Types
enum TrailingButtonType {
    case none
    case eye
    case calendar
    case dropdown
}

// MARK: - StaticLabelTextFieldView
class StaticLabelTextFieldView: UIView {
    public let titleLabel = UILabel()
    public let textField = UITextField()
    public let errorLabel = UILabel()
    private let borderView = UIView()
    private var trailingButton: UIButton?

    public var trailingButtonType: TrailingButtonType = .none {
        didSet { configureTrailingButton(trailingButtonType) }
    }

    // Callbacks
    public var calendarTapCallback: (() -> Void)?
    public var dropdownTapCallback: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        borderView.backgroundColor = .white
        borderView.layer.cornerRadius = 14
        borderView.layer.borderWidth = 1
        borderView.layer.borderColor = UIColor(hex: "#1C1C1C")?.cgColor
        borderView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(borderView)

        titleLabel.font = UIFont.ubuntuRegular(ofSize: 14)
        titleLabel.textColor = UIColor(hex: "#1C1C1C")
        titleLabel.backgroundColor = .white
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)

        textField.font = UIFont.ubuntuRegular(ofSize: 18)
        textField.borderStyle = .none
        textField.backgroundColor = .clear
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)

        errorLabel.font = UIFont.ubuntuRegular(ofSize: 14)
        errorLabel.textColor = .red
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.isHidden = true
        addSubview(errorLabel)

        NSLayoutConstraint.activate([
            borderView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            borderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            borderView.trailingAnchor.constraint(equalTo: trailingAnchor),
            borderView.heightAnchor.constraint(equalToConstant: 58),

            titleLabel.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: 12),
            titleLabel.topAnchor.constraint(equalTo: borderView.topAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            titleLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 60),

            textField.topAnchor.constraint(equalTo: borderView.topAnchor),
            textField.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -40),
            textField.bottomAnchor.constraint(equalTo: borderView.bottomAnchor),

            errorLabel.topAnchor.constraint(equalTo: borderView.bottomAnchor, constant: 3),
            errorLabel.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: 4),
            errorLabel.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -4),
            errorLabel.heightAnchor.constraint(equalToConstant: 14),
            errorLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -2)
        ])
    }

    private func configureTrailingButton(_ type: TrailingButtonType) {
        trailingButton?.removeFromSuperview()
        trailingButton = nil

        guard type != .none else { return }

        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        borderView.addSubview(button)
        trailingButton = button

        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: borderView.centerYAnchor),
            button.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -8),
            button.widthAnchor.constraint(equalToConstant: 28),
            button.heightAnchor.constraint(equalToConstant: 28)
        ])

        switch type {
        case .eye:
            button.setImage(UIImage(systemName: textField.isSecureTextEntry ? "eye" : "eye.slash"), for: .normal)
            button.tintColor = .gray
            button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
            textField.isSecureTextEntry = true
        case .calendar:
            button.setImage(UIImage(systemName: "calendar"), for: .normal)
            button.tintColor = .gray
            button.addTarget(self, action: #selector(calendarButtonTapped), for: .touchUpInside)
        case .dropdown:
            button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            button.tintColor = .gray
            button.addTarget(self, action: #selector(dropdownButtonTapped), for: .touchUpInside)
        default:
            break
        }
    }

    @objc private func togglePasswordVisibility() {
        textField.isSecureTextEntry.toggle()
        let imageName = textField.isSecureTextEntry ? "eye" : "eye.slash"
        trailingButton?.setImage(UIImage(systemName: imageName), for: .normal)
    }

    @objc private func calendarButtonTapped() {
        calendarTapCallback?()
    }

    @objc private func dropdownButtonTapped() {
        dropdownTapCallback?()
    }

    // MARK: - Public API
    func setTitle(_ title: String) {
        titleLabel.text = title
        let width = title.width(withConstrainedHeight: 20, font: titleLabel.font) + 16
        titleLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
    }

    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
        borderView.layer.borderColor = UIColor.red.cgColor
    }

    func hideError() {
        errorLabel.isHidden = true
        borderView.layer.borderColor = UIColor(hex: "#1C1C1C")?.cgColor
    }

    func setBorderColor(_ color: UIColor) {
        borderView.layer.borderColor = color.cgColor
    }
}

// Helper extension for dynamic label width
extension String {
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [.font: font],
                                            context: nil)
        return ceil(boundingBox.width)
    }
}

// MARK: - Example Usage

class ExampleVC: UIViewController {
    let passwordField = StaticLabelTextFieldView()
    let dobField = StaticLabelTextFieldView()
    let sexField = StaticLabelTextFieldView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Password
        passwordField.setTitle("Password")
        passwordField.textField.placeholder = "Enter password"
        passwordField.trailingButtonType = .eye

        // Date of Birth
        dobField.setTitle("Date of Birth")
        dobField.textField.placeholder = "Mar 12, 1984"
        dobField.trailingButtonType = .calendar
        dobField.calendarTapCallback = {
            print("Date Picker should show here.")
        }

        // Birth Sex
        sexField.setTitle("Birth Sex")
        sexField.textField.placeholder = "Select"
        sexField.trailingButtonType = .dropdown
        sexField.dropdownTapCallback = {
            print("Dropdown Picker should show here.")
        }

        // Layout the views...
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        dobField.translatesAutoresizingMaskIntoConstraints = false
        sexField.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(passwordField)
        view.addSubview(dobField)
        view.addSubview(sexField)
        
        NSLayoutConstraint.activate([
            passwordField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            dobField.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 30),
            dobField.leadingAnchor.constraint(equalTo: passwordField.leadingAnchor),
            dobField.trailingAnchor.constraint(equalTo: passwordField.trailingAnchor),

            sexField.topAnchor.constraint(equalTo: dobField.bottomAnchor, constant: 30),
            sexField.leadingAnchor.constraint(equalTo: dobField.leadingAnchor),
            sexField.trailingAnchor.constraint(equalTo: dobField.trailingAnchor),
        ])
    }
}


