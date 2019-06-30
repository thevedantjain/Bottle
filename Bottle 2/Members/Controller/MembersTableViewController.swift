//
//  MembersTableViewController.swift
//  Bottle 2
//
//  Created by Vedant Jain on 06/04/19.
//  Copyright © 2019 Vedant Jain. All rights reserved.
//

import UIKit

private let memberCellID = "memberCellID"

class MembersTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Members"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(MemberTableViewCell.self, forCellReuseIdentifier: memberCellID)

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: memberCellID, for: indexPath) as! MemberTableViewCell
        cell.titleLabel.text = "Member Name " + String(indexPath.item)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("selected row : ", String(indexPath.item))
    }

}
