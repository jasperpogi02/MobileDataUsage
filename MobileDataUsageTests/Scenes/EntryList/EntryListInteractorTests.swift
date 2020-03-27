//
//  EntryListInteractorTests.swift
//  MobileDataUsageTests
//
//  Created by Jasper Alain Goce on 27/3/20.
//

import XCTest
@testable import MobileDataUsage

class EntryListInteractorTests: XCTestCase {
    
    var sut: EntryListInteractor!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        do {
            try super.setUpWithError()
            sut = EntryListInteractor()
        } catch {
            XCTFail("Failed to setup: \(error)")
        }
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        do {
            sut = nil
            try super.setUpWithError()
        } catch {
            XCTFail("Failed to teardown: \(error)")
        }
    }
    
    // MARK: - Test doubles
    
    class EntryListPresentationLogicSpy: EntryListPresentationLogic {
        // MARK: Method call expectations
        
        var presentEntryListCalled = false
        
        // MARK: Spied methods
        
        func presentEntryList(response: EntryListModel.Response.EntryList?) {
            presentEntryListCalled = true
        }
    }
    
    class EntryListWorkerSpy: EntryListWorker {
        // MARK: Method call expectations
        
        var getEntryDataCalled = false
        
        // MARK: Spied methods
        
        override func getEntryData(completion: @escaping (EntryListModel.Response.EntryList?) -> Void) {
            getEntryDataCalled = true
            completion(MockData.EntryListData.sampleDisplayedEntryData)
        }
    }
    
    // MARK: - Tests
    
    func testGetEntryDataShouldAskEntryListWorkerToGetEntryDataAndPresenterToFormatResult() {
      // Given
      let entryListPresentationLogicSpy = EntryListPresentationLogicSpy()
      sut.presenter = entryListPresentationLogicSpy
      let entryListWorkerSpy = EntryListWorkerSpy(entryListStoreProtocol: EntryListMemStore())
      sut.worker = entryListWorkerSpy
      
      // When
      sut.getEntryData()
      
      // Then
      XCTAssert(entryListWorkerSpy.getEntryDataCalled, "GetEntryData() should ask EntryListWorker to fetch orders")
      XCTAssert(entryListPresentationLogicSpy.presentEntryListCalled, "GetEntryData() should ask presenter to format entry data result")
    }
    
}
