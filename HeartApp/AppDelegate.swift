//
//  AppDelegate.swift
//  HeartAI
//
//  Created by Cody Smith on 6/4/20.
//  Copyright © 2020 Cody Smith. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    /*lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "EventData")
    container.loadPersistentStores { description, error in
        if let error = error {
            fatalError("Unable to load persistent stores: \(error)")
        }
    
        }
        return container
    }()
    
    var window: UIWindow?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    */
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        /*
        if let rootVC = window?.rootViewController as? MainViewController {
            rootVC.container = persistentContainer
        }*/
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

