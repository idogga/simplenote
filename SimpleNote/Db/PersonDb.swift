//
//  Person.swift
//  SimpleNote
//
//  Created by Admin on 16/03/2020.
//  Copyright © 2020 tap. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class PersonDb{
    var name:String
    var lenght: Double
    var birth: Date
    
    init(name: String, lenght: Double, birth: Date) {
        self.name=name
        self.lenght=lenght
        self.birth=birth
    }
    
    init(db: NSManagedObject) {
        name = db.value(forKey: "name") as! String
        lenght = db.value(forKey: "lenght") as! Double
        birth = db.value(forKey: "age") as! Date
    }
    
    func insert() -> Void {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let personDb = NSEntityDescription.insertNewObject(forEntityName: "Person", into: context)
        personDb.setValue(name, forKey: "name")
        personDb.setValue(lenght, forKey: "lenght")
        personDb.setValue(birth, forKey: "age")
        appDelegate.saveContext()
    }
}

