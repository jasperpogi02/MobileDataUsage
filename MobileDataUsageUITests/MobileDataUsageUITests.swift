//
//  MobileDataUsageUITests.swift
//  MobileDataUsageUITests
//
//  Created by cdgtaxiMac on 3/24/20.
//

import XCTest

class MobileDataUsageUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app = nil
        super.tearDown()
    }
    
    func testDataConsumptionBreakdownCellHeight() {
        // Given
        let cell = app.tables.element(boundBy: 0).cells.element(boundBy: 3)
        
        // When
        cell.tap()
        
        // Then
        XCTAssertEqual(cell.frame.size.height, 111.0)
    }
}
