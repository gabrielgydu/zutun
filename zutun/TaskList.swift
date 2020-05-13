//
//  TaskList.swift
//  zutun
//
//  Created by Gabriel Schütz on 02.06.17.
//  Copyright © 2017 Gabriel Schütz. All rights reserved.
//

import UIKit
import os.log

class TaskList: NSObject, NSCoding {
    
    //MARK: Types
    struct PropertyKey {
        static let title = "title"
        static let tasks = "tasks"
    }
    
    //MARK: Properties
    
    var title: String
    var tasks: [Task]
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("taskLists")
    
    init?(title: String, tasks: [Task]) {
        guard !title.isEmpty else {
            return nil
        }
        
        self.title = title
        self.tasks = tasks
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: PropertyKey.title)
        aCoder.encode(tasks, forKey: PropertyKey.tasks)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // Decode data
        guard let title = aDecoder.decodeObject(forKey: PropertyKey.title) as? String else {
            os_log("Unable to decode the title for a TaskList object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        let tasks = aDecoder.decodeObject(forKey: PropertyKey.tasks) as? [Task]

        // Call init
        self.init(title: title, tasks: (tasks)!)
        
    }

    
    
}
