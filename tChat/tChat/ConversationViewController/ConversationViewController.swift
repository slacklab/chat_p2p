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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 44
    }
    
     override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIncomingMsg = tableView.dequeueReusableCell(withIdentifier: "IncomingMessageCell", for: indexPath)
        let cellOutcomingMsg = tableView.dequeueReusableCell(withIdentifier: "OutcomingMessageCell", for: indexPath)
        
        let cell = (indexPath.row % 2 == 0) ? cellIncomingMsg : cellOutcomingMsg
        
        return cell
    }
    
    func loadData(with: ConversationCell) {
        self.title = with.name
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 
    }
}
