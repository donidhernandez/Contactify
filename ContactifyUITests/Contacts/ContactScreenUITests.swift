//
//  ContactScreenUITests.swift
//  ContactifyUITests
//
//  Created by Doni on 6/13/23.
//

import XCTest

final class ContactScreenUITests: XCTestCase {
    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }
    
    func test_initial_render_shows_no_contacts_text() {
        XCTAssertTrue(app.staticTexts["👀 No Contacts"].exists)
        XCTAssertTrue(app.staticTexts["It's seems a lil empty here, create some contacts ☝🏻"].exists)
    }
}
