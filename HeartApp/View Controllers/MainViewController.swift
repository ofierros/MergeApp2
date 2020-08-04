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
    var eventArray = Array<EventRecord?>()
    var i = 0
    var noEventText = "No Arrhythmias Detected"
    var unviewedArrhythmias = 0
    
    @IBOutlet weak var mainLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options:
                        [[.alert, .sound, .badge]],
                               completionHandler: { (granted, error) in
        })
        UNUserNotificationCenter.current().delegate = self
        showText()
    }
    
    // Function to return main screen text to default message
    func showText(){
        mainLabel.text = noEventText
    }
    
    // Function to send notification when new event arrives
    func sendNotification(){
        let content = UNMutableNotificationContent()
        content.title = "New Arrhythmia Detected"
        content.subtitle = messageSubtitle
        content.body = "View history"
        UIApplication.shared.applicationIconBadgeNumber += 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        
        let requestIdentifier = "demoNotification"
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler : { (error) in})
        //Change main screen text to indicate unviewed arrhythmia
        unviewedArrhythmias += 1
        mainLabel.text = "\(unviewedArrhythmias) New Arrhythmia(s) \n Detected"
    }
    
    //Function to handle format of notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void){
        completionHandler([.alert, .sound])
    }
    
    // Function that prepares information for segue to event record table
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "idTableViewSegue" {   // If segue is to table view
                if let recordTableVC = segue.destination as? RecordTableViewController {
                    recordTableVC.eventArray = self.eventArray  // Pass record array
                }
            }
        }
        UIApplication.shared.applicationIconBadgeNumber = 0 // Set notification badge back to 0
        unviewedArrhythmias = 0
        showText()  // Reset main screen text back to default
    }
    
    func loadEvent(newEvent: EventRecord){
        self.eventArray.insert(newEvent, at: 0)
    }
    
    func receiveData(fromBT: Array<Character>) -> EventRecord{
        //First parse out the type of arrhythmia, example using 5 bits = 2^4 = 16 possibilities. For example purposes, we will consider 5 options
        // Bits 27-24 represent the type of arrhythmia
        let typeArrh = Int(String(fromBT[10]))
        var newName = ""
        var newDate: String = ""
        newDate.append(fromBT[0])
        newDate.append(fromBT[1])
        newDate.append("/")
        newDate.append(fromBT[2])
        newDate.append(fromBT[3])
        newDate.append("/")
        newDate.append(fromBT[4])
        newDate.append(fromBT[5])
        
        var newTime: String = ""
        newTime.append(fromBT[6])
        newTime.append(fromBT[7])
        newTime.append(":")
        newTime.append(fromBT[8])
        newTime.append(fromBT[9])
        
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
        
        return EventRecord(name: newName, date: newDate, time: newTime)!
        
    }
    //            Arrhythmia 0,   month 5,     day 22,      time 12:42, year 2020
    let example0 = [Character]("05222012420")

    //            Arrhythmia 1,   month 6,     day 30,      time 18:04, year 2020
    let example1 = [Character]("06302018041")

    //            Arrhythmia 2,   month 7,     day 6,       time 08:55, year 2020
    let example2 = [Character]("07062008552")

    //            Arrhythmia 3,   month 10,    day 31,      time 21:13, year 2020
    let example3 = [Character]("10312021133")

    //            Arrhythmia 4,   month 1,     day 1,       time 00:01, year 2021
    let example4 = [Character]("01010200014")

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
}

