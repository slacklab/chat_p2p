//
//  ConversationCell.swift
//  tChat
//
//  Created by z on 08/10/2018.
//  Copyright © 2018 Ivan Sorokoletov. All rights reserved.
//

import Foundation
import UIKit

protocol MessageCellConfiguration: class {
    var textMessage: String? { get set }
}

class MessageCell: UITableViewCell {
    
    @IBOutlet private var textMessageLabel: UILabel!
    
    var textMessage: String? {
        didSet{
            if let factTextMessage = textMessage {
                textMessageLabel?.text = factTextMessage
            } else {
                textMessageLabel?.text = ""
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
