//
//  ContactViewModel.swift
//  Contactify
//
//  Created by Doni on 6/9/23.
//

import Foundation
import CoreData

final class ContactViewModel: ObservableObject {
    
    @Published var contact: Contact
    @Published var hasError = false
    @Published private(set) var error: CreateValidatorImpl.CreateValidatorError?
    @Published private(set) var state: SubmissionState?

    let isNew: Bool
    private let provider: ContactsProvider
    private let context: NSManagedObjectContext
    
    private let validator: CreateValidator
    
    init(provider: ContactsProvider, contact: Contact? = nil, validator: CreateValidator = CreateValidatorImpl()) {
        self.validator = validator
        self.provider = provider
        self.context = provider.newContext
        if let contact,
           let existingContact = provider.exists(contact: contact, in: context) {
            self.contact = existingContact
            self.isNew = false
        } else {
            self.contact = Contact(context: context)
            self.isNew = true
        }
    }
    
    func save() throws {
        do {
            try validator.validate(contact)
            state = .submitting
            try provider.persists(in: context)
            state = .successful
        } catch {
            self.hasError = true
            self.state = .unsuccessful
            self.error = error as? CreateValidatorImpl.CreateValidatorError
        }
    }
    
}

extension ContactViewModel {
    enum SubmissionState {
        case unsuccessful
        case successful
        case submitting
    }
}
