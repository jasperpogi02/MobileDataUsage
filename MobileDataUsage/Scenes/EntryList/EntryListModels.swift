//
//  EntryListModels.swift
//  MobileDataUsage
//
//  Created by cdgtaxiMac on 3/24/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import Foundation

struct EntryListModel {
    // MARK: Object model for API requests
    
    struct Request {
    }
    
    // MARK: Object model for API responses
    
    struct Response {
        // MARK: - EntryList
        struct EntryList: Codable {
            let help: String
            let success: Bool
            let result: Result
        }

        // MARK: - Result
        struct Result: Codable {
            let resourceID: String
            let fields: [Field]
            let records: [Record]
            let links: Links
            let total: Int

            enum CodingKeys: String, CodingKey {
                case resourceID = "resource_id"
                case fields, records
                case links = "_links"
                case total
            }
        }

        // MARK: - Field
        struct Field: Codable {
            let type, id: String
        }

        // MARK: - Links
        struct Links: Codable {
            let start, next: String
        }

        // MARK: - Record
        struct Record: Codable {
            let volumeOfMobileData, quarter: String
            let id: Int

            enum CodingKeys: String, CodingKey {
                case volumeOfMobileData = "volume_of_mobile_data"
                case quarter
                case id = "_id"
            }
        }
    }
    
    // MARK: Object model for UI rendering
    
    struct ViewModel {
        var selectedIndex: IndexPath?
        var entryListData = [Response.Record]()
        var groupedListData = [NewEntryList]()
        init(entryListDataResponse: EntryListModel.Response.EntryList?) {
            //get the data from 2008 - 2018
            var rollingYear = ""
            var rollingData: Double = 0.0
            var currentRollingData: Double = 0.0
            var decreasing = false
            _ = entryListDataResponse?.result.records.filter({
                if let year = $0.quarter.components(separatedBy: "-").first,
                    let volumeData = Double($0.volumeOfMobileData) {
                    if rollingYear == year || rollingYear == "" {
                        rollingData += volumeData
                        rollingYear = year
                        if volumeData < currentRollingData {
                            decreasing = true
                        }
                        currentRollingData = volumeData
                    } else {
                        groupedListData.append(NewEntryList(year: rollingYear, totalData: rollingData, decrease: decreasing))
                        rollingData = volumeData
                        rollingYear = year
                        currentRollingData = volumeData
                        decreasing = false
                        
                    }
                }
                entryListData.append($0)
                return true
            })
            //filter grouped the data yearly
            groupedListData = groupedListData.filter({ Constant.validYears.contains($0.year) })
        }
        
        struct NewEntryList {
            let year: String
            let totalData: Double
            let decrease: Bool
            
            func getTotalData() -> String {
                return String(format: "%.2f", totalData)
            }
        }
    }
}
