//
//  AppDelegate.swift
//  Todoey
//
//  Created by Saul Juan Antonio Lionheart Cuautle on 7/20/19.
//  Copyright © 2019 Saul Juan Antonio Lionheart Cuautle. All rights reserved.
//

import UIKit
//import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        //print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)

       // print(Realm.Configuration.defaultConfiguration.fileURL)
        
//        let data = Data()
//        data.name = "Taylor"
//        data.age = 29
//
        do {
            _ = try Realm()
//            try realm.write {
//                realm.add(data)
        } catch {
            print("error initailizing new realm \(error)")
        }
        
        
        return true
    }
    
//    func applicationWillTerminate(_ application: UIApplication) {
//
//        self.saveContext()
//    }
//
//    // MARK: - Core Data stack
//
//    lazy var persistentContainer: NSPersistentContainer = {
//
//        let container = NSPersistentContainer(name: "DataModel")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//
//
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
//
//    // MARK: - Core Data Saving support
//
//    func saveContext () {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }
//
//

}
