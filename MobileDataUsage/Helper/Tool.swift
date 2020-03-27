//
//  Cache.swift
//  MobileDataUsage
//
//  Created by Jasper Alain Goce on 27/3/20.
//

import Foundation
import UIKit

class Tool {
    
    static let shared = Tool()
    
    func saveFile(data: Data) {
        let fileURL = try! FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("EntryListData.cache")
        
        do {
            try data.write(to: fileURL, options: .atomic)
        } catch {
            print(error)
        }
    }
    
    func getFile() -> Data? {
        let doumentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let filePath = doumentDirectoryPath.appendingPathComponent("EntryListData.cache")
        if FileManager.default.fileExists(atPath: filePath) {
            do {
                return try FileHandle(forReadingFrom: URL(fileURLWithPath: filePath)).availableData
            } catch let error as NSError {
                print("Error : \(error.localizedDescription)")
                return nil
            }
        } else {
            return nil
        }
    }
}
