//
//  EventRecord.swift
//  HeartAI
//
//  Created by Cody Smith on 6/23/20.
//  Copyright © 2020 Algorrhythmics. All rights reserved.
//

import UIKit
import os.log

class EventRecord: NSObject/*, NSCoding */{
        
    //MARK: Properties
    
    var name: String
    var date: String
    var time: String
    
    init?(name: String, date: String, time: String){
        if name.isEmpty || date.isEmpty || time.isEmpty{
            return nil
        }
        self.name = name
        self.date = date
        self.time = time
    }
    
    //MARK: Archiving Paths
    /*
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("events")
    
    //MARK: Types
    struct PropertyKey{
        static let name = "name"
        static let date = "date"
        static let time = "time"
    }
    
    //MARK: NSCoding
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: PropertyKey.name)
        coder.encode(date, forKey: PropertyKey.date)
        coder.encode(time, forKey: PropertyKey.time)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        //The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String
        else { os_log("Unable to decode the name for an EventRecord object.", log: OSLog.default, type:.debug)
            return nil
        }
        //The date is required. If we cannot decode a date string, the initializer should fail.
        guard let date = aDecoder.decodeObject(forKey: PropertyKey.date) as? String
        else { os_log("Unable to decode the date for an EventRecord object.", log: OSLog.default, type:.debug)
            return nil
        }
        //The time is required. If we cannot decode a time string, the initializer should fail.
        guard let time = aDecoder.decodeObject(forKey: PropertyKey.time) as? String
        else { os_log("Unable to decode the time for an EventRecord object.", log: OSLog.default, type:.debug)
            return nil
        }
        
        //Must call designated initializer
        self.init(name: name, date: date, time:time)
    }*/
    
}
