//
//  ContactsProvider.swift
//  Contactify
//
//  Created by Doni on 6/9/23.
//

import Foundation
import CoreData
import SwiftUI

final class ContactsProvider {
    
    static var shared = ContactsProvider()
    private let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    var newContext: NSManagedObjectContext {
        persistentContainer.newBackgroundContext()
    }
    
    private init () {
        persistentContainer = NSPersistentContainer(name: "ContactsDataModel")
        if EnvironmentValues.isPreview {
            persistentContainer.persistentStoreDescriptions.first?.url = .init(fileURLWithPath: "/dev/null")
        }
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        persistentContainer.loadPersistentStores { _, error in
            if let error {
                fatalError("Unable to load store with \(error)")
            }
        }
    }
    
    func exists(contact: Contact, in context: NSManagedObjectContext) -> Contact? {
        try? context.existingObject(with: contact.objectID) as? Contact
    }
    
    func persists(in context: NSManagedObjectContext) throws {
        if context.hasChanges {
            try context.save()
        }
    }
    
    func delete(_ contact: Contact, context: NSManagedObjectContext) throws {
        if let existingContact = exists(contact: contact, in: context) {
            context.delete(existingContact)
            Task(priority: .background) {
                try await context.perform {
                    try context.save()
                }
            }
        }
    }
}
