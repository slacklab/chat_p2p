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
   
    static var previousState = UIApplication.shared.applicationState
    class func printStateWithFunction(_ function: String) {
   
        #if DEBUG
        let currentState = UIApplication.shared.applicationState
        print("Application moved from <\(previousState.parseToString())>, to <\(currentState.parseToString())>: \(function)\n")

        previousState = currentState
        #else
        #endif
    }
    
    class func printViewLifeCycle(_ function: String) {
        
        #if DEBUG
        print("\(function)\n")
        #else
        #endif
    }
    
}
    




