//
//  String-Ext.swift
//  MyOwnWorkout
//
//  Created by Алмаз Рахматуллин on 14.06.2023.
//

import Foundation
extension String {
    
    func phoneMask(to mask: String! = "+# (###) ###-##-##") -> String {
        //привет
        // ["п", "р", "и", "в", "е", "т"]
        
        let phone = self
        
        //1 проверка первого символа 8 или +7
//        if phone.first == "8" {
//            phone.removeFirst()
//            phone = "7" + phone
//        }
        
        //2
        let separated = phone.components(separatedBy: CharacterSet.decimalDigits.inverted)
        print(separated)
        let joined = separated.joined()
        
        var result = ""
        var index = joined.startIndex
        
        for ch in mask where index < joined.endIndex {
            
            if ch == "#" {
                result.append(joined[index])
                index = joined.index(after: index)
            } else {
                result.append(ch)
            }
        }
        
        return result
    }
}

