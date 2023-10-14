//
//  FileManagerExtensions.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 29.07.2023.
//

import Foundation

extension FileManager {
    
    //MARK: - Сохранение объекта в директорию
    
    class func setObject(data: Data, name: String, type of: String) -> Bool {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return false }
        let fileName = directory.appendingPathComponent(name)
        let filePath = fileName.appendingPathExtension(of)
//        print(filePath.absoluteString)
        
        do {
            try? FileManager.default.removeItem(at: filePath)
            try data.write(to: filePath)
            return true
        }
        catch let error {
            print(error.localizedDescription)
            return false
        }
    }
    
    //MARK: - Получение объекта из директории
    
    class func getObject(name: String, type of: String) -> Data? {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let fileName = directory.appendingPathComponent(name)
        let filePath = fileName.appendingPathExtension(of)
//        print(filePath.absoluteString)
        
        do {
            return try Data.init(contentsOf: filePath)
        }
        catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}
