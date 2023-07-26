//
//  FileManager-Ext.swift
//  MyOwnWorkout
//
//  Created by Алмаз Рахматуллин on 26.07.2023.
//

import Foundation
extension FileManager {
    
    class func saveObject(data: Data, name: String, of type: String) -> Bool {
        guard let file = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return false}
        let directory = file.appendingPathComponent(name)
        let path = directory.appendingPathExtension(type)
        print(path.absoluteString)
        
        do {
            try? FileManager.default.removeItem(at: path)
            try data.write(to: path)
            return true
        }
        catch let error {
            print(error.localizedDescription)
            return false
        }
    }
    
    class func getObject(name: String, of type: String) -> Data? {
        guard let file = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
        let directory = file.appendingPathComponent(name)
        let path = directory.appendingPathExtension(type)
        print(path.absoluteString)
        
        do {
            return try Data.init(contentsOf: path)
        }
        catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}
