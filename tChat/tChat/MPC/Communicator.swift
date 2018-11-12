//
//  Communicator.swift
//  tChat
//
//  Created by z on 28/10/2018.
//  Copyright © 2018 Ivan Sorokoletov. All rights reserved.
//

import Foundation

protocol Communicator {

    func sendMessage(string: String, to userId: String, completionHandler: ((_ success: Bool, _ error: Error?) -> Void)?)
    var online: Bool {get set}

    var delegate: CommunicatorDelegate? {get set}

}
