//
//  AppDelegate.swift
//  Todoey
//
//  Created by Thomas Ingolia on 7/30/19.
//  Copyright © 2019 Thomas Ingolia. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // print file location for realm data storage
      //  print(Realm.Configuration.defaultConfiguration.fileURL)

        do {
           _ = try Realm()
        } catch {
            print("Error with realm : (error)")
        }
        // Override point for customization after application launch.
        return true
    }

 
    // MARK: - Core Data stack
    




}

