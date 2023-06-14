//
//  ModelTests.swift
//  ContactifyTests
//
//  Created by Doni on 6/13/23.
//

import XCTest
@testable import Contactify

final class ModelTests: XCTestCase {

    private var provider: ContactsProvider!
    
    override func setUp() {
        provider = .shared
    }
    
    override func tearDown() {
        provider = nil
    }

    func test_contact_is_empty () {
        let contact: Contact = Contact.empty(context: provider.viewContext)
        
        XCTAssertEqual(contact.firstName, "")
        XCTAssertEqual(contact.lastName, "")
        XCTAssertEqual(contact.email, "")
        XCTAssertEqual(contact.phoneNumber, "")
        XCTAssertEqual(contact.notes, "")
        XCTAssertFalse(contact.isFavorite)
        XCTAssertTrue(Calendar.current.isDateInToday(contact.dayOfBirth))
        
    }
    
    func test_contact_is_not_valid () {
        let contact: Contact = Contact.empty(context: provider.viewContext)
        XCTAssertFalse(contact.isValid)
    }
    
    func test_contact_is_valid() {
        let contact: Contact = Contact.preview(context: provider.viewContext)
        XCTAssertTrue(contact.isValid)
    }
    
    func test_make_contact_preview_is_valid() {
        let count = 6
        let contacts: [Contact] = Contact.makePreview(count: count, in: provider.viewContext)
        
        for i in 0..<contacts.count {
            let contact = contacts[i]
            
            XCTAssertTrue(!contact.firstName.isEmpty)
            XCTAssertTrue(!contact.lastName.isEmpty)
            XCTAssertTrue(!contact.email.isEmpty)
            XCTAssertEqual(contact.phoneNumber, "+1(743)-330-154\(i)")
            
            let dateToCompare = Calendar.current.date(byAdding: .day, value: -i, to: .now)
            let dayOfBirth = Calendar.current.dateComponents([.day], from: contact.dayOfBirth, to: dateToCompare!).day
            
            XCTAssertEqual(dayOfBirth, 0)
            XCTAssertEqual(contact.notes, "This is a preview for item \(i)")
        }
    }
    
    func test_filter_favorite_contacts_request_is_valid() {
        let request = Contact.filter(with: .init(filter: .fave))
        XCTAssertEqual("isFavorite == 1", request.predicateFormat)
    }
    
    func test_filter_all_contacts_request_is_valid() {
        let request = Contact.filter(with: .init(filter: .all))
        XCTAssertEqual("TRUEPREDICATE", request.predicateFormat)
    }
    
    func test_filter_all_with_query_contacts_request_is_valid() {
        let query = "Doni"
        let request = Contact.filter(with: .init(query: query))
        XCTAssertEqual("firstName CONTAINS[cd] \"\(query)\" OR lastName CONTAINS[cd] \"\(query)\"", request.predicateFormat)
    }
    
    func test_filter_fave_with_query_contacts_request_is_valid() {
        let query = "Doni"
        let request = Contact.filter(with: .init(query: query, filter: .fave))
        XCTAssertEqual("(firstName CONTAINS[cd] \"\(query)\" OR lastName CONTAINS[cd] \"\(query)\") AND isFavorite == 1", request.predicateFormat)
    }
}
