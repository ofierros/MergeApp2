//
//  MainViewController.swift
//  HeartAI
//
//  Created by Cody Smith on 6/4/20.
//  Copyright © 2020 Cody Smith. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications


class MainViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    var messageSubtitle = "You have a new event to review"
    var sampEvents = Array<EventRecord?>()
    var i = 0

    //            Arrhythmia 0,   month 5,     day 22,      time 12:42, year 2020
    let example0 = 0x00000000 | ( (0x5<<20) | (0x16<<15) | (0x2FA<<4) | (0x0) )

    //            Arrhythmia 1,   month 6,     day 30,      time 18:04, year 2020
    let example1 = 0x01000000 | ( (0x6<<20) | (0x1E<<15) | (0x43C<<4) | (0x0) )

    //            Arrhythmia 2,   month 7,     day 6,       time 08:55, year 2020
    let example2 = 0x02000000 | ( (0x7<<20) | (0x06<<15) | (0x217<<4) | (0x0) )

    //            Arrhythmia 3,   month 10,    day 31,      time 21:13, year 2020
    let example3 = 0x03000000 | ( (0xA<<20) | (0x1F<<15) | (0x4F9<<4) | (0x0) )

    //            Arrhythmia 4,   month 1,     day 1,       time 00:01, year 2021
    let example4 = 0x04000000 | ( (0x1<<20) | (0x01<<15) | (0x001<<4) | (0x1) )

    @IBAction func buttonPressed(_ sender: UIButton) {
        switch(i){
        case 0: loadEvent(newEvent: receiveData(fromBT: example0))
                sendNotification()
                i = i + 1
                break
        case 1: loadEvent(newEvent: receiveData(fromBT: example1))
                sendNotification()
                i = i + 1
                break
        case 2: loadEvent(newEvent: receiveData(fromBT: example2))
                sendNotification()
                i = i + 1
                break
        case 3: loadEvent(newEvent: receiveData(fromBT: example3))
                sendNotification()
                i = i + 1
                break
        case 4: loadEvent(newEvent: receiveData(fromBT: example4))
                sendNotification()
                i = i + 1
                break
        default:loadEvent(newEvent: receiveData(fromBT: example0))
                sendNotification()
                i = 1
                break
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options:
                        [[.alert, .sound, .badge]],
                               completionHandler: { (granted, error) in
        })
        UNUserNotificationCenter.current().delegate = self
    }
    
    func sendNotification(){
        let content = UNMutableNotificationContent()
        content.title = "New Arrhythmia Detected"
        content.subtitle = messageSubtitle
        content.body = "View history"
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        
        let requestIdentifier = "demoNotification"
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler : { (error) in})
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void){
        completionHandler([.alert, .sound])
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "idTableViewSegue" {
                if let recordTableVC = segue.destination as? RecordTableViewController {
                    recordTableVC.sampEvents = self.sampEvents
                }
            }
        }
    }
    
    func loadEvent(newEvent: EventRecord){
        self.sampEvents.insert(newEvent, at: 0)
    }
    
    func receiveData(fromBT: Int) -> EventRecord{
        //First parse out the type of arrhythmia, example using 5 bits = 2^4 = 16 possibilities. For example purposes, we will consider 5 options
        // Bits 27-24 represent the type of arrhythmia
        var typeArrh: Int = fromBT & (0x0F000000)
        var newName = ""
        var newDate = ""
        var newTime = ""
        
        typeArrh = typeArrh>>24
        switch(typeArrh){
        case 0: newName = "Atrial Fibrillation"
            break
        case 1: newName = "Atrial tachycardia"
            break
        case 2: newName = "Ventricular fibrillation"
            break
        case 3: newName = "Ventricular tachycardia"
            break
        case 4: newName = "Heart block"
            break
        default: newName = "Outside of demonstration"
            break
        }
        // Bits 23-20 represent months 0-12
        var month = (fromBT & 0x00F00000)
        month = month>>20
        // Bits 19-15 represent days of the month from 1-31
        var day = (fromBT & 0x000F8000)
        day = day>>15
        // Bits 14-4 represent minutes of the day from 0 (midnight) to 11:59pm (23:59)
        var mins = (fromBT & 0x00007FF0)
        mins = mins>>4
        // Bits 3-0 used for number of years since 2020
        let year = (2020 + (fromBT & 0x0000000F) )
        // Bits 31-28 unused for now
        
        //Logic to parse out months
        if ((month > 12) || day > 31) {
           newDate = "Invalid date"
        }
        else if ((month >= 10) && (day >= 10)){
            newDate = "\(month)-\(day)-\(year)"
        }
        else if((month < 10) && (day < 10)){
            newDate = "0\(month)-0\(day)-\(year)"
        }
        else if((month >= 10) && (day < 10)){
            newDate = "\(month)-0\(day)-\(year)"
        }
        else if((month < 10) && (day >= 10)){
            newDate = "0\(month)-\(day)-\(year)"
        }
        else{
            newDate = "Invalid Date"
        }
        // Logic to parse out hours and minutes
        if(mins > 1440){
           newTime = "Invalid time"
        }
        else if((mins/60 >= 10) && (mins%60 >= 10)){
            newTime = "\(mins/60):\(mins%60)"
        }
        else if((mins/60 < 10) && (mins%60 >= 10)){
            newTime = "0\(mins/60):\(mins%60)"
        }
        else if((mins/60 >= 10) && (mins%60 < 10)){
            newTime = "\(mins/60):0\(mins%60)"
        }
        else if((mins/60 < 10) && (mins%60 < 10)){
            newTime = "0\(mins/60):0\(mins%60)"
        }
        else{
            newTime = "Invalid Time"
        }
        
        return EventRecord(name: newName, date: newDate, time: newTime)!
        
    }
}

