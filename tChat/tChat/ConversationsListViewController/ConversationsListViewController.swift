//
//  ConversationsListViewController.swift
//  tChat
//
//  Created by z on 08/10/2018.
//  Copyright © 2018 Ivan Sorokoletov. All rights reserved.
//

import Foundation
import UIKit

class MessageManager: NSObject {
    
    var name: String?
    var message: String?
    var date: Date?
    var online: Bool
    var hasUnreadMessage: Bool
    
    init(currentName: String, currentMessage: String , currentDate: Date, currentOnline: Bool, currentHasUnreadMessage: Bool) {
        self.name = currentName
        self.message = currentMessage
        self.date = currentDate
        self.online = currentOnline
        self.hasUnreadMessage = currentHasUnreadMessage
    }
    
    init(currentName: String,  currentDate: Date, currentOnline: Bool, currentHasUnreadMessage: Bool) {
        self.name = currentName
        self.date = currentDate
        self.online = currentOnline
        self.hasUnreadMessage = currentHasUnreadMessage
    }
    
    init(currentDate: Date, currentOnline: Bool, currentHasUnreadMessage: Bool) {
        self.date = currentDate
        self.online = currentOnline
        self.hasUnreadMessage = currentHasUnreadMessage
    }
    
    init(currentMessage: String, currentDate: Date, currentOnline: Bool, currentHasUnreadMessage: Bool) {
        self.date = currentDate
        self.message = currentMessage
        self.online = currentOnline
        self.hasUnreadMessage = currentHasUnreadMessage
    }
    
}

//MARK: constants for MessageManager - generates differents conversations

let namesArray: [String] = ["Ivan Sorokoletov", "", "LooooooooooooooooongNaaaaaameeeeeeeeee"]
let messagesArray = ["Looooooooonnnngggg teeeeexttttttttttttttttttttttt", "Emoji 🎾"]
let dateArray = [ Date(), Date(timeIntervalSinceReferenceDate: 111111111)]

class ConversationsListViewController: UITableViewController, ThemesViewControllerDelegate {
    
    
    func themesViewController(_ controller: ThemesViewController, didSelectTheme selectedTheme: UIColor) {
        print("into protocol")
        logThemeChanging(selectedTheme: selectedTheme)

    }
    
    func logThemeChanging(selectedTheme: UIColor) {
        #if DEBUG
        print("Test")
        print("Now Theme is \(selectedTheme)")
        #endif
    }
      
    
    var сellsMessagesOnline = [MessageManager]()
    var сellsMessagesOffline = [MessageManager]()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0:
            return сellsMessagesOnline.count
        case 1:
            return сellsMessagesOffline.count
        default:
            return 0
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConversationCell", for: indexPath) as! ConversationCell
        var tmpCell:MessageManager
        
        switch (indexPath.section) {
            
        case 0:
            tmpCell = сellsMessagesOnline[indexPath.row]
        case 1:
            tmpCell = сellsMessagesOffline[indexPath.row]
        default:
            tmpCell = сellsMessagesOnline[indexPath.row]
        }
        
        cell.name = tmpCell.name
        cell.message = tmpCell.message
        cell.date = tmpCell.date
        cell.online = tmpCell.online
        cell.hasUnreadMessage = tmpCell.hasUnreadMessage
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch (section) {
        case 0:
            return "Online"
        case 1:
            return "History"
        default:
            return "Error"
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateConversations()
 
        
    }
    

    
    
    
    func generateConversations() {

        // For Online users
        
        for itemName in 0 ..< namesArray.count {
            for itemMessage in 0 ..< messagesArray.count {
                for itemDate in 0 ..< dateArray.count {
                    сellsMessagesOnline.append(MessageManager(currentName: namesArray[itemName], currentMessage: messagesArray[itemMessage], currentDate: dateArray[itemDate], currentOnline: true, currentHasUnreadMessage: false))
                }
            }
        }
        
        // For Offline users
        for itemName in 0 ..< namesArray.count {
            for itemMessage in 0 ..< messagesArray.count {
                for itemDate in 0 ..< dateArray.count {
                    сellsMessagesOffline.append(MessageManager(currentName: namesArray[itemName], currentMessage: messagesArray[itemMessage], currentDate: dateArray[itemDate], currentOnline: false, currentHasUnreadMessage: true))
                }
            }
        }
        
        //MARK: special cases for Online
        
        // If incoming message does not exist -> no messages yet
        сellsMessagesOnline.append(MessageManager(currentName: namesArray[0], currentDate: dateArray[0], currentOnline: true, currentHasUnreadMessage: false))
        
        // For Unread messages -> bold font

        сellsMessagesOnline.append(MessageManager(currentName: namesArray[0], currentMessage: messagesArray[0], currentDate: dateArray[0], currentOnline: true, currentHasUnreadMessage: true))
        
        // For Without Name
        сellsMessagesOnline.append(MessageManager(currentMessage: messagesArray[0], currentDate: dateArray[0], currentOnline: true, currentHasUnreadMessage: true))

        //MARK: special cases for Offline
        
        // If incoming message does not exist -> no messages yet
        сellsMessagesOffline.append(MessageManager(currentName: namesArray[1], currentDate: dateArray[1], currentOnline: false, currentHasUnreadMessage: false))
        
        // For Read messages -> standart font
        сellsMessagesOffline.append(MessageManager(currentName: namesArray[1], currentMessage: messagesArray[1], currentDate: dateArray[1], currentOnline: false, currentHasUnreadMessage: false))
        
        // For Without Name
        сellsMessagesOffline.append(MessageManager(currentMessage: messagesArray[1], currentDate: dateArray[1], currentOnline: false, currentHasUnreadMessage: false))
        
    }
    
    
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier {
            
        case "toConversationViewController":
            if let cell = sender as? ConversationCell, let conversationViewController = segue.destination as? ConversationViewController {
                conversationViewController.loadData(with: cell)
            }
            
        default:
            return
        }
    }
    
}
