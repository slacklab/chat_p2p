//
//  ComunicateDelegates.swift
//  tChat
//
//  Created by z on 28/10/2018.
//  Copyright © 2018 Ivan Sorokoletov. All rights reserved.
//

import Foundation

protocol CommunicatorDelegate : class {
    
    func didFoundUser(userId: String, userName: String?)
    func didLostUser(userId: String)
    func didReceiveMessage(text: String, fromUser: String, toUser: String)
    func failedToAdvertise(error: Error)
    func failedToBrowseUsers(error: Error)
    
}

protocol CommunicationDelegate : class {
    func updateUserData()
    func handleError(error: Error)
}


