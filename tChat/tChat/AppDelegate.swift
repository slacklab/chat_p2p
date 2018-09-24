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
    

    var bufferState = UIApplication.shared.applicationState
    var currentState = UIApplication.shared.applicationState
    let instanceOfLogger = Logger()

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        instanceOfLogger.printLog(bufferState: bufferState, currentState: currentState)
        #if DEBUG
        print("\(#function)\n")
        #else
        #endif

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        
        instanceOfLogger.printLog(bufferState: bufferState, currentState: currentState)
        #if DEBUG
        print("\(#function)\n")
        #else
        #endif
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        instanceOfLogger.printLog(bufferState: bufferState, currentState: currentState)
        #if DEBUG
        print("\(#function)\n")
        #else
        #endif
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        
        instanceOfLogger.printLog(bufferState: bufferState, currentState: currentState)
        #if DEBUG
        print("\(#function)\n")
        #else
        #endif
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
       
        instanceOfLogger.printLog(bufferState: bufferState, currentState: currentState)
        #if DEBUG
        print("\(#function)\n")
        #else
        #endif
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        instanceOfLogger.printLog(bufferState: bufferState, currentState: currentState)
        #if DEBUG
        print("\(#function)\n")
        #else
        #endif
    }
    
    
}

