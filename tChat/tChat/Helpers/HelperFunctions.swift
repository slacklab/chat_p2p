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
   
    func printLog(bufferState: UIApplicationState, currentState: UIApplicationState) {
        #if DEBUG
    
        let currentState = UIApplication.shared.applicationState
        print("Application moved from <\(bufferState.parseToString())>, to <\(currentState.parseToString())>: ")
        _ = UIApplication.shared.applicationState
    
        #else
        #endif
    }
    
}
    




