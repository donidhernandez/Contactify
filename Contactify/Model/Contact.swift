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
    
    override func awakeFromInsert() {
        super.awakeFromInsert()
        
        setPrimitiveValue(Date.now, forKey: "dayOfBirth")
        setPrimitiveValue(Bool.random(), forKey: "isFavorite")
    }
}
