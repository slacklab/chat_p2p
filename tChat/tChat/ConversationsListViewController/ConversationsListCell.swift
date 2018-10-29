//
//  ConversationsListCell.swift
//  tChat
//
//  Created by z on 08/10/2018.
//  Copyright © 2018 Ivan Sorokoletov. All rights reserved.
//

import Foundation
import UIKit

protocol ConversationCellConfiguration: class {
    var name: String? { get set }
    var message: String? { get set }
    var date: Date? { get set }
    var online: Bool { get set }
    var hasUnreadMessage: Bool { get set }
}

class ConversationCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    var name: String? {
        didSet {
            if let factName = name {
                nameLabel?.text = factName
                
            } else {
                nameLabel?.text = "Unknown"
            }
        }
    }
    

    
    var message: String? {
        didSet {
            if let factLastMessage = message {
                self.lastMessageLabel.text = factLastMessage
                
            } else {
                self.lastMessageLabel.text = "No messages yet"
                self.lastMessageLabel.font = UIFont.italicSystemFont(ofSize:self.lastMessageLabel.font.pointSize)
            }
        }
    }
    
    var date: Date? {
        didSet {
            if let factDate = date {
                let calendar = Calendar.current
                
                if calendar.isDateInToday(factDate) {
                    let hhmmFormatter = DateFormatter()
                    hhmmFormatter.dateFormat = "HH:mm"
                    dateTimeLabel?.text = hhmmFormatter.string(from: factDate)
                
                } else {
                    let ddmmFormatter = DateFormatter()
                    ddmmFormatter.dateFormat = "dd MMM"
                    dateTimeLabel?.text = ddmmFormatter.string(from: factDate)
                }
            }
        }
    }
    
    var online: Bool = false {
        didSet {
            if online {
                self.backgroundColor = UIColor(named: "LightYellowCustom")
                
            } else {
                self.backgroundColor = UIColor(named: "white")
            }
        }
    }
    var hasUnreadMessage: Bool = false {
        didSet {
            if message == nil {
                return
            }
            
            if hasUnreadMessage {
                self.lastMessageLabel.font = UIFont.boldSystemFont(ofSize: lastMessageLabel.font.pointSize)
                
            } else {
                self.lastMessageLabel.font = UIFont.systemFont(ofSize: lastMessageLabel.font.pointSize)
            }
        }
    }
    
    func configureForLabels (name: String?, textLastMessage: String?, dateLastMessage: Date?, isOnline: Bool, hasUnreadMessage: Bool) {
        self.name = name
        self.message = textLastMessage
        self.date = dateLastMessage
        self.online = isOnline
        self.hasUnreadMessage = hasUnreadMessage
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
