//
//  UIApplicationStateParseToString.swift
//  tChat
//
//  Created by z on 24/09/2018.
//  Copyright © 2018 Ivan Sorokoletov. All rights reserved.
//

import Foundation
import UIKit

extension UIApplicationState {
    
    func parseToString() -> String {
        switch self {
        case .active:
            return "Active: (receiving events)"
        case .inactive:
            return "Inactive: (is not receiving events)"
        case .background:
            return "Background"
        }
    }
    
}
