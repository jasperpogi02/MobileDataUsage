//
//  MockData.swift
//  MobileDataUsageTests
//
//  Created by Jasper Alain Goce on 27/3/20.
//

import Foundation
@testable import MobileDataUsage
import XCTest

struct MockData {
    struct EntryListData {
        static let sampleDisplayedEntryData = EntryListModel.Response.EntryList(help: "https://data.gov.sg/api/3/action/help_show?name=datastore_search", success: true, result: EntryListModel.Response.Result(resourceID: "a807b7ab-6cad-4aa6-87d0-e283a7353a0f", fields: [EntryListModel.Response.Field(type: "int4", id: "_id")], records: [EntryListModel.Response.Record(volumeOfMobileData: "0.171586", quarter: "2008-Q1", id: 15)], links: EntryListModel.Response.Links(start: "/api/action/datastore_search?resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f", next: "/api/action/datastore_search?offset=100&resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f"), total: 1))
    }
}
