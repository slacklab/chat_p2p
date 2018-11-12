//
//  ConversationsListViewController.swift
//  tChat
//
//  Created by z on 08/10/2018.
//  Copyright © 2018 Ivan Sorokoletov. All rights reserved.
//

import Foundation
import UIKit

struct UserInfo {

    var name: String
}

class MessageManager: NSObject {

    var userID: String

    var name: String?
    var message: String?
    var date: Date?
    var online: Bool
    var hasUnreadMessage: Bool
    var messageHistory: [Message] = []

    enum Message {
        case incoming(String)
        case outgoing(String)
    }

    init(userID: String, name: String?) {
        self.userID = userID
        self.name = name
        hasUnreadMessage = false
        online = true
    }

}

class ConversationsListViewController: UITableViewController, ThemesViewControllerDelegate, CommunicationDelegate {
    func updateUserData() {
        listConversations = Array(CommunicationManager.shared.conversationDictionary.values)
        sortConversations()
        tableView.reloadData()
    }

    func handleError(error: Error) {
        print("error")
    }

    var listConversations: [MessageManager] = []
    let cellId = "ConversationCell"

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CommunicationManager.shared.delegate = self
        updateUserData()
    }

    func sortConversations() {
        listConversations.sort(by: sortFunction(firstUser:secondUser:))
    }

    func sortFunction(firstUser: MessageManager, secondUser: MessageManager) -> Bool {
        if let firstDate = firstUser.date, let firstName = firstUser.name {
            if let secondDate = secondUser.date, let secondName = secondUser.name {
                if firstDate.timeIntervalSinceNow != secondDate.timeIntervalSinceNow {
                    return firstDate.timeIntervalSinceNow > secondDate.timeIntervalSinceNow
                }

                return firstName > secondName
            }

            return true
        } else {
            return false
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return listConversations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConversationCell", for: indexPath) as! ConversationCell
        // swiftlint:enable force_cast

        let userConversation = listConversations[indexPath.row]
        cell.name = userConversation.name
        cell.message = userConversation.message
        cell.date = userConversation.date
        cell.hasUnreadMessage = userConversation.hasUnreadMessage
        cell.online = userConversation.online
        return cell

    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return ["Online", "History"][section]

    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "openConversation", sender: indexPath)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openConversation", let indexPath = sender as? IndexPath {
            //swiftlint:disable : force_cast
            let conversationViewController = segue.destination as! ConversationViewController
            //swiftlint:enable : force_cast
            let userConversation: MessageManager
            userConversation = listConversations[indexPath.row]
            conversationViewController.userConversation = userConversation
            if listConversations[indexPath.row].name == "" {
                conversationViewController.navigationItem.title = "No name"
            } else {
                conversationViewController.navigationItem.title = listConversations[indexPath.row].name
            }
        }
    }

}
