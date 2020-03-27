//
//  EntryListAPIStore.swift
//  MobileDataUsage
//
//  Created by cdgtaxiMac on 3/24/20.
//

import Foundation

class EntryListAPIStore: EntryListStoreProtocol {
    
    func getEntryData(completion: @escaping(EntryListModel.Response.EntryList?) -> Void) {
        let session = URLSession(configuration: .default)
        var urlComponent = URLComponents(string: Constant.dataURL)
        urlComponent?.queryItems = [
            URLQueryItem(name: "resource_id", value: Constant.resourceID)
        ]
        if let url = urlComponent?.url {
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "GET"
            let task = session.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print(error as Any)
                    return
                }
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    print(httpStatus)
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let entryData = try decoder.decode(EntryListModel.Response.EntryList.self, from: data)
                    Tool.shared.saveFile(data: data)
                    completion(entryData)
                } catch {
                    completion(nil)
                }
            }
            task.resume()
        }
    }
}

