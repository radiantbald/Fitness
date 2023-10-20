//
//  KeyChain.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 30.07.2023.
//

import Foundation
import KeychainSwift

class KeychainDataBase {
    static var standart: KeychainSwift = KeychainSwift()
    private init() {}
}
