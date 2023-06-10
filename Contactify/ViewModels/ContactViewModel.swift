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
    let isNew: Bool
    private let provider: ContactsProvider
    private let context: NSManagedObjectContext
    
    init(provider: ContactsProvider, contact: Contact? = nil) {
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
        try provider.persists(in: context)
    }
    
}
