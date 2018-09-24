//
//  HelperFunctions.swift
//  tChat
//
//  Created by z on 23/09/2018.
//  Copyright © 2018 Ivan Sorokoletov. All rights reserved.
//

import Foundation
import UIKit

class Logger {
   
    func printAppStateChanged(prevState: String, currentState: String, methodName: String) {
    #if DEBUG
        print("I'm running in DEBUG mode")
        let currentState = UIApplication.shared.applicationState

        
        print("Application moved from <стейт из которого переходим = \(prevState)>, to <стейт в который переходим = \(currentState)>: <здесь название метода = \(methodName)>")
    
    
    #else
   // print("I'm running in a non-DEBUG mode")
    
    
    #endif
    }
    
}


