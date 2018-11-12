//
//  AppDelegate.swift
//  tChat
//
//  Created by z on 23/09/2018.
//  Copyright © 2018 Ivan Sorokoletov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let coreDataManager: CoreDataManager = CoreDataManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Logger.printStateWithFunction(#function)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        Logger.printStateWithFunction(#function)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        Logger.printStateWithFunction(#function)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        Logger.printStateWithFunction(#function)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        Logger.printStateWithFunction(#function)
    }

    func applicationWillTerminate(_ application: UIApplication) {
            Logger.printStateWithFunction(#function)

        if let saveContext = coreDataManager.coreDataStack.saveContext {
            coreDataManager.coreDataStack.performSave(context: saveContext)
        }

    }

}
