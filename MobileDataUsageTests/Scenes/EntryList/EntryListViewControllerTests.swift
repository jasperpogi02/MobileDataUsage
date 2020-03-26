//
//  EntryListViewControllerTests.swift
//  MobileDataUsageTests
//
//  Created by Jasper Alain Goce on 26/3/20.
//

import XCTest
@testable import MobileDataUsage

class EntryListViewControllerTests: XCTestCase {
    
    var sut: EntryListViewController!
    
    let sampleDisplayedEntryData = EntryListModel.Response.EntryList(help: "https://data.gov.sg/api/3/action/help_show?name=datastore_search", success: true, result: EntryListModel.Response.Result(resourceID: "a807b7ab-6cad-4aa6-87d0-e283a7353a0f", fields: [EntryListModel.Response.Field(type: "int4", id: "_id")], records: [EntryListModel.Response.Record(volumeOfMobileData: "0.171586", quarter: "2008-Q1", id: 15)], links: EntryListModel.Response.Links(start: "/api/action/datastore_search?resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f", next: "/api/action/datastore_search?offset=100&resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f"), total: 1))
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sut = EntryListViewController()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Test doubles
    
    class EntryListBusinessLogicSpy: EntryListBusinessLogic {
        
        // MARK: Method call expectations
        
        var getEntryDataCalled = false
        
        // MARK: Spied methods
        
        func getEntryData() {
            getEntryDataCalled = true
        }
    }
    
    class TableViewSpy: UITableView {
        // MARK: Method call expectations
        
        var reloadDataCalled = false
        
        // MARK: Spied methods
        
        override func reloadData() {
            reloadDataCalled = true
        }
        
    }
    
    // MARK: - Tests
    
    func testShouldGetEntryDataWhenViewDidLoad() {
        // Given
        let entryListBusinessLogicSpy = EntryListBusinessLogicSpy()
        sut.interactor = entryListBusinessLogicSpy
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssert(entryListBusinessLogicSpy.getEntryDataCalled, "Should get entry data right after the view appears")
    }
    
    func testShouldDisplayFetchedOrders() {
        // Given
        let tableViewSpy = TableViewSpy()
        sut.myView.dataUsageTable = tableViewSpy
        
        // When
        let viewModel = EntryListModel.ViewModel(entryListDataResponse: sampleDisplayedEntryData)
        sut.displayEntryList(viewModel: viewModel)
        
        // Then
        DispatchQueue.main.async {
            XCTAssert(tableViewSpy.reloadDataCalled, "Displaying fetched orders should reload the table view")
        }
    }
    
    func testShouldConfigureTableViewCellToDisplayOrder() {
        // Given
        let tableView = sut.myView.dataUsageTable
        var testEntryData: EntryListModel.ViewModel?
        do {
            if let file = Bundle.main.url(forResource: "mock", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let decoder = JSONDecoder()
                do {
                    let data = try decoder.decode(EntryListModel.Response.EntryList.self, from: data)
                    testEntryData = EntryListModel.ViewModel(entryListDataResponse: data)
                } catch (let error) {
                    print(error)
                }
            } else {
                print("Cannot read file")
            }
        } catch (let error) {
            print(error)
        }
        sut.myView.viewModel = testEntryData
        
        // When
        tableView.reloadData()
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView(tableView, cellForRowAt: indexPath) as? EntryListCell

        // Then
        XCTAssertEqual(cell?.textLbl.text!, "2008 Data Consumption: 1.54", "A properly configured table view cell should display the data consumption on year 2008")
    }
    
}
