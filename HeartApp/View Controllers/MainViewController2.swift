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
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        sendNotification()
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
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let requestIdentifier = "demoNotification"
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler : { (error) in})
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void){
        completionHandler([.alert, .sound])
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    

}

