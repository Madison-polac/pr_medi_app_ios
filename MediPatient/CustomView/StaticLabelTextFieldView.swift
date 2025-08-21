//
//  StaticLabelTextFieldView.swift
//  MediPatient
//
//  Created by Nick Joliya on 21/08/25.
//

import UIKit

class StaticLabelTextFieldView: UIView {

    // UI Elements
    public let titleLabel = UILabel()
    public let textField = UITextField()
    public let errorLabel = UILabel()
    private let borderView = UIView()
    private var eyeButton: UIButton?

    public var showsEyeButton: Bool = false {
        didSet { configureEyeButton(showsEyeButton) }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        // Border View
        borderView.backgroundColor = .white
        borderView.layer.cornerRadius = 14
        borderView.layer.borderWidth = 1
        borderView.layer.borderColor = UIColor.gray.cgColor
        borderView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(borderView)

        // Title Label (left aligned, overlay border)
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        titleLabel.textColor = .darkGray
        titleLabel.backgroundColor = .white
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)

        // Text Field
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.borderStyle = .none
        textField.backgroundColor = .clear
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)

        // Error Label
        errorLabel.font = UIFont.systemFont(ofSize: 12)
        errorLabel.textColor = .red
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.isHidden = true
        addSubview(errorLabel)

        // Layout constraints
        NSLayoutConstraint.activate([
            // Border view
            borderView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            borderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            borderView.trailingAnchor.constraint(equalTo: trailingAnchor),
            borderView.heightAnchor.constraint(equalToConstant: 58),

            // Overlay title label - LEFT aligned and overlays
            titleLabel.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: 12),
            titleLabel.topAnchor.constraint(equalTo: borderView.topAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            titleLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 60),

            // Text field
            textField.topAnchor.constraint(equalTo: borderView.topAnchor),
            textField.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -40), // leave space for eye button
            textField.bottomAnchor.constraint(equalTo: borderView.bottomAnchor),

            // Error label
            errorLabel.topAnchor.constraint(equalTo: borderView.bottomAnchor, constant: 3),
            errorLabel.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: 4),
            errorLabel.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -4),
            errorLabel.heightAnchor.constraint(equalToConstant: 14),
            errorLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -2)
        ])
    }

    private func configureEyeButton(_ show: Bool) {
        if show {
            if eyeButton == nil {
                let button = UIButton(type: .custom)
                let eyeImage = UIImage(systemName: "eye")
                button.setImage(eyeImage, for: .normal)
                button.tintColor = .gray
                button.translatesAutoresizingMaskIntoConstraints = false
                button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
                borderView.addSubview(button)
                eyeButton = button

                NSLayoutConstraint.activate([
                    button.centerYAnchor.constraint(equalTo: borderView.centerYAnchor),
                    button.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -8),
                    button.widthAnchor.constraint(equalToConstant: 28),
                    button.heightAnchor.constraint(equalToConstant: 28)
                ])
            }
            textField.isSecureTextEntry = true
        } else {
            eyeButton?.removeFromSuperview()
            eyeButton = nil
            textField.isSecureTextEntry = false
        }
    }

    @objc private func togglePasswordVisibility() {
        textField.isSecureTextEntry.toggle()
        let imageName = textField.isSecureTextEntry ? "eye" : "eye.slash"
        eyeButton?.setImage(UIImage(systemName: imageName), for: .normal)
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
        borderView.layer.borderColor = UIColor.gray.cgColor
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

