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
    
    func testFirstCellLabelShouldBeYear2008() {
        // Given
        let firstCellLabel = app.staticTexts["dataConsumption"].firstMatch
        
        // When
        let elementQuery = firstCellLabel.label.contains("2008")
        
        // Then
        XCTAssert(elementQuery, "First cell label shown is not of year 2008")
        
    }
    
    func testLatestCellLabelShouldBeYear2018() {
        // Given
        let lastCellLabel = app.staticTexts.element(boundBy: 10)
        
        // When
        let elementQuery = lastCellLabel.label.contains("2018")
        
        // Then
        XCTAssert(elementQuery, "Last cell label shown is not of year 2018")
        
    }
}
