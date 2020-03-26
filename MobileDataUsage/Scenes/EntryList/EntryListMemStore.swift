//
//  EntryListMemStore.swift
//  MobileDataUsage
//
//  Created by Jasper Alain Goce on 26/3/20.
//

import Foundation

class EntryListMemStore: EntryListStoreProtocol {
    func getEntryData(completion: @escaping (EntryListModel.Response.EntryList?) -> Void) {
        do {
            if let file = Bundle.main.url(forResource: "mock", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let decoder = JSONDecoder()
                do {
                    completion(try decoder.decode(EntryListModel.Response.EntryList.self, from: data))
                } catch (let error) {
                    print(error)
                    completion(nil)
                }
            } else {
                print("Cannot read file")
                completion(nil)
            }
        } catch (let error) {
            print(error)
            completion(nil)
        }
    }
}
