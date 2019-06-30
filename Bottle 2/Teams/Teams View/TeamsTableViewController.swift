//
//  TeamsTableViewController.swift
//  Bottle 2
//
//  Created by Vedant Jain on 06/04/19.
//  Copyright © 2019 Vedant Jain. All rights reserved.
//

import UIKit

private let teamCellID = "teamCellID"

class TeamsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        self.title = "Teams"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(TeamTableViewCell.self, forCellReuseIdentifier: teamCellID)
        
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.backgroundColor = .white
        
        tableView.separatorStyle = .none
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: teamCellID, for: indexPath) as! TeamTableViewCell
        cell.backgroundCard.backgroundColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.0)
        cell.titleLabel.text = "Team Name"
        cell.descLabel.text = "Lorem Ipsum"
        cell.numberOfMembersLabel.text = String(7) + " members"
        cell.selectionStyle = .none
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Open team interview ", String(indexPath.item))
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let teamsOverviewCollectionViewController = TeamOverviewCollectionViewController(collectionViewLayout: layout)
        self.navigationController?.pushViewController(teamsOverviewCollectionViewController, animated: true)
    }

}
