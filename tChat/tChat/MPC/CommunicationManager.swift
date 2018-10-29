//
//  CommunicationManager.swift
//  tChat
//
//  Created by z on 28/10/2018.
//  Copyright © 2018 Ivan Sorokoletov. All rights reserved.
//

import Foundation

class CommunicationManager: CommunicatorDelegate {
    
    static let shared = CommunicationManager()
    var dataManager = GCDProfileDataManager()
    var communicator: MultipeerCommunicator!
    weak var delegate: CommunicationDelegate?
    
    private init() {
        dataManager.getProfile { (profile) in
            self.communicator = MultipeerCommunicator(profile: profile)
            self.communicator.delegate = self
        }
    }
    
        var conversationDictionary: [String : MessageManager] = [:]

    
    func didFoundUser(userId: String, userName: String?) {
        if let userConversation = conversationDictionary[userId] {
            userConversation.online = true
        } else {
            let userConversation = MessageManager(userID: userId, name: userName)
           
            
            

            userConversation.online = true
            conversationDictionary[userId] = userConversation
        }
        guard let delegate = delegate else { return }
        DispatchQueue.main.async {
            delegate.updateUserData()
        }
    }
    
    func didLostUser(userId: String) {
        if let userConversation = conversationDictionary[userId] {
            userConversation.online = false
            conversationDictionary.removeValue(forKey: userId)
        }
        guard let delegate = delegate else { return }
        DispatchQueue.main.async {
            delegate.updateUserData()
        }
    }
    
    func didReceiveMessage(text: String, fromUser: String, toUser: String) {
        if let userConversation = conversationDictionary[fromUser] {
            _ = MessageManager.Message.incoming(text)
            userConversation.date = Date()
            userConversation.message = text
            userConversation.hasUnreadMessage = true
        } else if let userConversation = conversationDictionary[toUser] {
            _ = MessageManager.Message.outgoing(text)
            userConversation.date = Date()
            userConversation.message = text
        }
        guard let delegate = delegate else { return }
        DispatchQueue.main.async {
            delegate.updateUserData()
        }
    }

    
    func failedToBrowseUsers(error: Error) {
        guard let delegate = delegate else { return }
        DispatchQueue.main.async {
            delegate.handleError(error: error)
        }
    }
    
    func failedToAdvertise(error: Error) {
        guard let delegate = delegate else { return }
        DispatchQueue.main.async {
            delegate.handleError(error: error)
        }
    }
    
}
