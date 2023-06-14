//
//  CreateValidatorTests.swift
//  ContactifyTests
//
//  Created by Doni on 6/13/23.
//

import XCTest
@testable import Contactify

final class CreateValidatorTests: XCTestCase {
    
    private var validator: CreateValidatorImpl!
    private var provider: ContactsProvider!
    
    override func setUp() {
        provider = .shared
        validator = CreateValidatorImpl()
    }
    
    override func tearDown() {
        validator = nil
        provider = nil
    }
    
    func test_with_empty_contact_first_name_error_thrown() {
        let contact = Contact.empty(context: provider.viewContext)
        
        XCTAssertThrowsError(try validator.validate(contact), "Error for an empty first name should be thrown")
        
        do {
            _ = try validator.validate(contact)
            
        } catch {
            guard let validatorError = error as? CreateValidatorImpl.CreateValidatorError else {
                XCTFail("Got the wrong type of error, expecting a create validator error")
                return
            }
            
            XCTAssertEqual(validatorError, CreateValidatorImpl.CreateValidatorError.invalidFirstName, "Expecting an error where we have an invalid first name")
        }
    }
    
    func test_with_empty_first_name_error_thrown() {
        let contact = Contact(context: provider.viewContext)
        
    }
}
