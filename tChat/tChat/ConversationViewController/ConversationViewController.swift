//
//  ConversationViewController.swift
//  tChat
//
//  Created by z on 08/10/2018.
//  Copyright © 2018 Ivan Sorokoletov. All rights reserved.
//

import Foundation
import UIKit

class ConversationViewController: UITableViewController {

    var userConversation: MessageManager!

    @IBOutlet var sendMessageTextField: UITextField!
    @IBOutlet var sendButton: UIButton!

    @IBAction func sendButtonTapped(_ sender: Any) {
        if let text = sendMessageTextField.text {
            CommunicationManager.shared.communicator.sendMessage(string: text,
                                                                 to: userConversation.userID) { success, error in
                if success {
                    self.sendMessageTextField.text = ""
                    self.sendButton.isEnabled = false
                }
                if let error = error {
                    print(error.localizedDescription)
                    self.view.endEditing(true)
                    let alert = UIAlertController(title: "Error while sending", message: nil, preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ок", style: .default, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }

    @IBAction func sendMessageTFTapped(_ sender: Any) {
        if sendMessageTextField.text == "" {
            sendButton.isEnabled = false
        } else if userConversation.online {
            sendButton.isEnabled = true
        }
    }

    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 44

        CommunicationManager.shared.delegate = self
        setupKeyboard()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollToLastRow()
        sendButton.clipsToBounds = true
        sendButton.isEnabled = false
        userConversation.hasUnreadMessage = false

    }

    // MARK: TableView

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var reuseIdentifier: String
        var cell: MessageCell
        // swiftlint:disable force_cast

        switch userConversation.messageHistory[indexPath.row] {
        case .incoming(let message):
            reuseIdentifier = "incomingMsgCell"
            cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MessageCell

            cell.textMessage = message
        case .outgoing(let message):
            reuseIdentifier = "outgoingMsgCell"
            cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MessageCell

            cell.textMessage = message

        }
        // swiftlint:enable force_cast

        return cell

    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }

     override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    // MARK: Keyboard

    @objc func hideKeyboard(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    @objc private func keyboardWillShow(_ notification: NSNotification) {
        guard let info = notification.userInfo, let keyboardFrameValue = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardFrameValue.cgRectValue
        _ = keyboardFrame.size
        UIView.animate(withDuration: 0) {
            self.view.layoutIfNeeded()
            self.scrollToLastRow()
        }
    }

    @objc private func keyboardWillHidden() {
        UIView.animate(withDuration: 0) {
            self.view.layoutIfNeeded()
        }
    }

    func setupKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(gesture:)))
        view.addGestureRecognizer(tapGesture)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHidden), name: UIResponder.keyboardWillHideNotification, object: nil)

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }

    func loadData(with: ConversationCell) {
        self.title = with.name
    }

    func scrollToLastRow() {
        if userConversation.messageHistory.count != 0 {
            let indexPath = IndexPath(row: userConversation.messageHistory.count - 1, section: 0)
            tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
    }

}

extension ConversationViewController: CommunicationDelegate {

    func updateUserData() {
        if !userConversation.online {
            sendButton.isEnabled = false
        }
        userConversation.hasUnreadMessage = false
        tableView.reloadData()
        scrollToLastRow()
    }

    func handleError(error: Error) {
        self.view.endEditing(true)
        let alertController = UIAlertController(title: "Not connect", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
}
