//
//  Task.swift
//  zutun
//
//  Created by Gabriel Schütz on 02.06.17.
//  Copyright © 2017 Gabriel Schütz. All rights reserved.
//

import UIKit
import os.log

class Task: NSObject, NSCoding {
    
    //MARK: Types
    struct PropertyKey {
        static let taskName = "taskName"
        static let taskDescription = "taskDescription"
        static let isCompleted = "isCompleted"
        static let hasReminder = "hasReminder"
    }
    
    //MARK: Properties
    
    var taskName: String
    var taskDescription: String
    var isCompleted: Bool
    var hasReminder: Bool
    //private var geotification
    //private var time
    //dateCompleted
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("tasks")
    
    init?(taskName: String, task Description: String, isCompleted: Bool, hasReminder: Bool) {// failable initializer, fails if name is empty
        
        guard !taskName.isEmpty else {
            return nil
        }
        
        self.taskName = taskName
        self.taskDescription = taskDescription
        self.isCompleted = isCompleted
        self.hasReminder = hasReminder

    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(taskName, forKey: PropertyKey.taskName)
        aCoder.encode(taskDescription, forKey: PropertyKey.taskDescription)
        aCoder.encode(isCompleted, forKey: PropertyKey.isCompleted)
        aCoder.encode(hasReminder, forKey: PropertyKey.hasReminder)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // Decode data
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.taskName) as? String else {
            os_log("Unable to decode the name for a Task object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        let description = aDecoder.decodeObject(forKey: PropertyKey.taskDescription) as? String
        let completed = aDecoder.decodeBool(forKey: PropertyKey.isCompleted)
        let reminder = aDecoder.decodeBool(forKey: PropertyKey.hasReminder)
        
        // Call init
        self.init(taskName: name, taskDescription: description!, isCompleted: completed, hasReminder: reminder)
        
    }
    
    
    
}
