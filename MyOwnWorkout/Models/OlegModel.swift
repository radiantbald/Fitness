//
//  OlegModel.swift
//  MyOwnWorkout
//
//  Created by Алмаз Рахматуллин on 18.10.2023.
//

import RealmSwift

class Exercises: Object {
   @Persisted(primaryKey: true) var _id: ObjectId
   @Persisted var name: String = ""
   @Persisted var surname: String = ""

    convenience init(name: String, surname: String = "") {
       self.init()
       self.name = name
       self.surname = surname
   }
}
