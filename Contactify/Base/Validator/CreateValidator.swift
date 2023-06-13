//
//  CreateValidator.swift
//  Contactify
//
//  Created by Doni on 6/9/23.
//

import Foundation

protocol CreateValidator {
    func validate(_ contact: Contact) throws
}

struct CreateValidatorImpl: CreateValidator {
    func validate(_ contact: Contact) throws {
        if contact.firstName.isEmpty {
            throw CreateValidatorError.invalidFirstName
        }
        
        if contact.lastName.isEmpty {
            throw CreateValidatorError.invalidLastName
        }
        
        if contact.phoneNumber.isEmpty {
            throw CreateValidatorError.emptyPhoneNumber
        } else {
            let phoneRegex = "^\\d{3}\\d{3}\\d{4}$"
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            if !phoneTest.evaluate(with: contact.phoneNumber) {
                throw CreateValidatorError.invalidPhoneNumber
            }
        }
        
        if !contact.email.isEmpty {
            let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
            
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            if !emailTest.evaluate(with: contact.email) {
                throw CreateValidatorError.invalidEmail
            }
        }
    }
}

extension CreateValidatorImpl {
    enum CreateValidatorError: LocalizedError {
        case invalidFirstName
        case invalidLastName
        case invalidEmail
        case emptyPhoneNumber
        case invalidPhoneNumber
    }
}

extension CreateValidatorImpl.CreateValidatorError {
    
    var errorDescription: String? {
        switch self {
        case .invalidFirstName:
            return "First name can't be empty"
        case .invalidLastName:
            return "Last name can't be empty"
        case .invalidEmail:
            return "The email format is not valid"
        case .invalidPhoneNumber:
            return "The phone number is not valid"
        case .emptyPhoneNumber:
            return "Phone number can't be empty"
        }
    }
}
