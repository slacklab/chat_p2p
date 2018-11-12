//
//  UIApplicationStateParseToString.swift
//  tChat
//
//  Created by z on 24/09/2018.
//  Copyright © 2018 Ivan Sorokoletov. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication.State {

    func parseToString() -> String {
        switch self {
        case .active:
            return "Active"
        case .inactive:
            return "Inactive"
        case .background:
            return "Background"
        }
    }

}
