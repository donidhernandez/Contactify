//
//  Contact.swift
//  Contactify
//
//  Created by Doni on 6/9/23.
//

import Foundation
import CoreData
import SwiftUI

final class Contact: NSManagedObject, Identifiable {
    
    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var phoneNumber: String
    @NSManaged var dayOfBirth: Date
    @NSManaged var isFavorite: Bool
    @NSManaged var notes: String
    @NSManaged var email: String
    
    var isValid: Bool {
        !firstName.isEmpty &&
        !lastName.isEmpty &&
        !phoneNumber.isEmpty
    }
    
    override func awakeFromInsert() {
        super.awakeFromInsert()
        
        setPrimitiveValue(Date.now, forKey: "dayOfBirth")
        setPrimitiveValue(Bool.random(), forKey: "isFavorite")
    }
}

extension Contact {
    
    private static var contactsFetchRequest: NSFetchRequest<Contact> {
        NSFetchRequest(entityName: "Contact")
    }
    
    static func all() -> NSFetchRequest<Contact> {
        let request: NSFetchRequest = contactsFetchRequest
        
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Contact.firstName, ascending: true)
        ]
        
        return request
    }
    
    static func filter(with config: SearchConfig) -> NSPredicate {
        switch config.filter {
        case .all:
            return config.query.isEmpty ? NSPredicate(value: true) : NSPredicate(format: "firstName CONTAINS[cd] %@ OR lastName CONTAINS[cd] %@", config.query, config.query)
        case .fave:
            return config.query.isEmpty ? NSPredicate(format: "isFavorite == %@", NSNumber(value: true)) : NSPredicate(format: "firstName CONTAINS[cd] %@ OR lastName CONTAINS[cd] %@ AND isFavorite == %@", config.query, config.query, NSNumber(value: true))
        }
    }
    
    static func sort(order: Sort) -> [NSSortDescriptor] {
        [NSSortDescriptor(keyPath: \Contact.firstName, ascending: order == .asc)]
    }
}

extension Contact {
    
    @discardableResult
    static func makePreview(count: Int, in context: NSManagedObjectContext) -> [Contact] {
        var contacts = [Contact]()
        
        for i in 0..<count {
            let contact = Contact(context: context)
            let firstName = NameList.names.randomElement()!
            
            contact.firstName = firstName
            contact.lastName = NameList.names.randomElement()!
            
            contact.email = firstName.lowercased().randomEmail(currentStringAsUsername: true)
            contact.phoneNumber = "+1(743)-330-154\(i)"
            contact.isFavorite = Bool.random()
            contact.notes = "This is a preview for item \(i)"
            contact.dayOfBirth = Calendar.current.date(byAdding: .day, value: -i, to: .now) ?? .now
            
            contacts.append(contact)
        }
        
        return contacts
    }
    
    static func preview(context: NSManagedObjectContext = ContactsProvider.shared.viewContext) -> Contact {
        return makePreview(count: 1, in: context)[0]
    }
    
    static func empty(context: NSManagedObjectContext = ContactsProvider.shared.viewContext) -> Contact {
        return Contact(context: context)
    }
}
