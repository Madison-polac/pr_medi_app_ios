//
//  ValidationHelper.swift
//  MediPatient
//
//  Created by Nick Joliya on 11/08/25.
//


import Foundation

final class ValidationHelper {
    
    // MARK: - Email Validation
    static func isValidEmail(_ email: String?) -> Bool {
        guard let email = email?.trimmingCharacters(in: .whitespacesAndNewlines),
              !email.isEmpty else { return false }
        
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
    }
    
    // MARK: - Password Validation
    static func isValidPassword(_ password: String?, minLength: Int = 6, requireSpecialChar: Bool = false) -> Bool {
        guard let password = password, !password.isEmpty else { return false }
        guard password.count >= minLength else { return false }
        
        if requireSpecialChar {
            let specialCharRegex = ".*[^A-Za-z0-9].*"
            if NSPredicate(format: "SELF MATCHES %@", specialCharRegex).evaluate(with: password) == false {
                return false
            }
        }
        return true
    }
    
    // MARK: - Mobile Number Validation
    static func isValidMobileNumber(_ mobile: String?, minLength: Int = 8, maxLength: Int = 15) -> Bool {
        guard let mobile = mobile?.trimmingCharacters(in: .whitespacesAndNewlines),
              !mobile.isEmpty else { return false }
        
        let regex = "^[0-9]{\(minLength),\(maxLength)}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: mobile)
    }
    
    // MARK: - Name Validation
    static func isValidName(_ name: String?, minLength: Int = 2) -> Bool {
        guard let name = name?.trimmingCharacters(in: .whitespacesAndNewlines),
              !name.isEmpty else { return false }
        
        let regex = "^[A-Za-z ]{\(minLength),}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: name)
    }
    
    // MARK: - Empty Field Check
    static func isEmpty(_ text: String?) -> Bool {
        return text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true
    }
}
