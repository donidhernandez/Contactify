//
//  CreateScreenUITests.swift
//  ContactifyUITests
//
//  Created by Doni on 6/14/23.
//

import XCTest

final class CreateScreenUITests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }
    
    func test_when_create_is_tapped_create_view_is_presented() {
        let createBtn = app.buttons["createButton"]
        XCTAssertTrue(createBtn.exists, "The create button should be visible on the screen")
        
        createBtn.tap()
        
        let navigationBars = app.navigationBars["New Contact"]
        let firstNameTxtField = app.textFields["firstNameTxtField"]
        let lastNameTxtField = app.textFields["lastNameTxtField"]
        let emailTxtField = app.textFields["emailTxtField"]
        let phoneNumberTxtField = app.textFields["phoneNumberTxtField"]
        let birthDayPicker = app.datePickers["birthDayPicker"]
        let favoriteToggle = app.switches["favoriteToggle"]
        let notesTxtField = app.textFields["notesTxtField"]
        
        XCTAssertTrue(navigationBars.exists)
        XCTAssertTrue(firstNameTxtField.exists)
        XCTAssertTrue(lastNameTxtField.exists)
        XCTAssertTrue(emailTxtField.exists)
        XCTAssertTrue(phoneNumberTxtField.exists)
        XCTAssertTrue(birthDayPicker.exists)
        XCTAssertTrue(favoriteToggle.exists)
        XCTAssertTrue(notesTxtField.exists)
    }
    
    func test_valid_form_submission_is_successful() {
        let createBtn = app.buttons["createButton"]
        XCTAssertTrue(createBtn.exists, "The create button should be visible on the screen")
        
        createBtn.tap()
        
        let firstNameTxtField = app.textFields["firstNameTxtField"]
        let lastNameTxtField = app.textFields["lastNameTxtField"]
        let emailTxtField = app.textFields["emailTxtField"]
        let phoneNumberTxtField = app.textFields["phoneNumberTxtField"]
        
        firstNameTxtField.tap()
        firstNameTxtField.typeText("Doni")
        
        lastNameTxtField.tap()
        lastNameTxtField.typeText("Dominguez")
        
        emailTxtField.tap()
        emailTxtField.typeText("donih@gmail.com")
        
        phoneNumberTxtField.tap()
        phoneNumberTxtField.typeText("8542341234")
        
        let submitBtn = app.buttons["submitBtn"]
        XCTAssertTrue(submitBtn.exists, "The submit button should be visible on the screen")
        
        submitBtn.tap()
        
        XCTAssertTrue(app.navigationBars["Contacts"].waitForExistence(timeout: 5), "There should be a navigation bar title Contacts")
        
        let contactCreated = app.staticTexts["Doni Dominguez"]
        
        XCTAssertTrue(contactCreated.exists)
        
    }
    
    
    func test_when_cancel_is_tapped_create_view_is_dismissed() {
        let createBtn = app.buttons["createButton"]
        XCTAssertTrue(createBtn.exists, "The create button should be visible on the screen")

        createBtn.tap()

        let cancelButton = app.buttons["cancelButton"]
        XCTAssertTrue(cancelButton.waitForExistence(timeout: 0.25), "The cancel button should be visible on the screen")
        
        cancelButton.tap()
        
        XCTAssertTrue(app.navigationBars["Contacts"].waitForExistence(timeout: 5), "There should be a navigation bar title Contacts")
    }
}
