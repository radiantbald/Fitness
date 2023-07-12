//
//  StringExtentions.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 16.06.2023.
//

import Foundation

extension String {
    
    //MARK: -
    func setLettersNumbersAndUnderscoreSymbols(string: String) -> String {
        
        var newString = ""
        
        for i in string {
            if i.isLetter || i.isNumber || i == "_" {
                newString.append(i)
            }
        }
        return newString
    }
    
    //MARK: -
    func setLettersHyphenAndApostropheSymbols(string: String) -> String {
        
        var newString = ""
        
        for i in string {
            if i.isLetter || i == "-" || i == "`" {
                newString.append(i)
            }
        }
        return newString
    }
    
    //MARK: -
    func setCapitalLetters() -> String {
        return prefix(1).uppercased() + self.dropFirst()
    }
    
    //MARK: -
    func setOnlyNumbers(string: String) -> String {
        
        var newString = ""
        
        for i in string {
            if i.isNumber {
                newString.append(i)
            }
        }
        return newString
    }
    
    //MARK: -
    func phoneMaskRu(to mask: String! = "+# (###) ###-##-##") -> String {
        
        var phoneNumber = self
        
        if phoneNumber.first == "8" {
            phoneNumber.removeFirst()
            phoneNumber = "7" + phoneNumber
        }
        
        let separated = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted)
        let joined = separated.joined()
        
        var result = ""
        var index = joined.startIndex
        
        for i in mask where index < joined.endIndex {
            
            if i == "#" {
                result.append(joined[index])
                index = joined.index(after: index)
            } else {
                result.append(i)
            }
        }
        return result
    }
    
    //MARK: - 
    func codeFromSMSMask(to mask: String! = "#-#-#-#-#-#") -> String {
        
        let codeFromSMS = self
        
        let separated = codeFromSMS.components(separatedBy: CharacterSet.decimalDigits.inverted)
        let joined = separated.joined()
        
        var result = ""
        var index = joined.startIndex
        
        for i in mask where index < joined.endIndex {
            
            if i == "#" {
                result.append(joined[index])
                index = joined.index(after: index)
            } else {
                result.append(i)
            }
        }
        return result
    }
}
