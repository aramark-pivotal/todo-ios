//
//  TodoListUITests.swift
//  TodoListUITests
//
//  Created by Pivotal on 2/13/17.
//  Copyright © 2017 Pivotal. All rights reserved.
//

import XCTest

class TodoListUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
    }
    
}
