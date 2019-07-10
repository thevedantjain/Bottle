//
//  MembersTableViewController.swift
//  Bottle 2
//
//  Created by Vedant Jain on 06/04/19.
//  Copyright © 2019 Vedant Jain. All rights reserved.
//

import UIKit
import Alamofire

private let memberCellID = "memberCellID"

class MembersTableViewController: UITableViewController {

    let colors: [UIColor] = [UIColor(red:0.23, green:0.28, blue:0.93, alpha:0.7), UIColor(red:0.86, green:0.34, blue:0.22, alpha:0.7)]
    var tabViewControllerInstance: TabViewController?
    var users: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Members"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.separatorStyle = .none
        
        tableView.register(MemberTableViewCell.self, forCellReuseIdentifier: memberCellID)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        users = tabViewControllerInstance?.users ?? [User(id: -1, username: "fuck", createdAt: "", updatedAt: "")]
        print(users)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: memberCellID, for: indexPath) as! MemberTableViewCell
        cell.backgroundCard.backgroundColor = colors[indexPath.item % colors.count]
        cell.titleLabel.text = "@" + (users[indexPath.item].username ?? "username")
        cell.idLabel.text = "ID: " + String(users[indexPath.item].id ?? -1)
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

}
