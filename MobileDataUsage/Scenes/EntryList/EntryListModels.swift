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
    }
    
    // MARK: Object model for UI rendering
    
    struct ViewModel {
        var entryListData = [Entry]()
        struct Entry {
            var data: Double?
            var quarter: String?
        }
    }
}
