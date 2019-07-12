//
//  TeamsTableViewController.swift
//  Bottle 2
//
//  Created by Vedant Jain on 06/04/19.
//  Copyright © 2019 Vedant Jain. All rights reserved.
//

import UIKit
import Alamofire

private let teamCellID = "teamCellID"

class ProjectsTableViewController: UITableViewController {
    
    let colors: [UIColor] = [UIColor(red:0.23, green:0.28, blue:0.93, alpha:0.7), UIColor(red:0.86, green:0.34, blue:0.22, alpha:0.7), UIColor(red:0.18, green:0.60, blue:0.68, alpha:1.0), UIColor(red:0.89, green:0.56, blue:0.37, alpha:1.0)]
    
    var projects: [Project] = []
    
    var homeCollectionViewControllerInstance: HomeCollectionViewController?
    
    let dispatchGroup: DispatchGroup = DispatchGroup()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        self.title = "Projects"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(ProjectTableViewCell.self, forCellReuseIdentifier: teamCellID)
        
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.backgroundColor = .white
        
        tableView.separatorStyle = .none
        
    }

    override func viewDidAppear(_ animated: Bool) {
        if homeCollectionViewControllerInstance?.projects.isEmpty == true {
            projects = [Project(id: -1, name: "Could not get data", createdBy: 6, createdAt: "", updatedAt: "", workspace: 1)]
            tableView.reloadData()
            return
        }
        projects = homeCollectionViewControllerInstance?.projects ?? [Project(id: -1, name: "Not working", createdBy: 6, createdAt: "", updatedAt: "", workspace: 1)]
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: teamCellID, for: indexPath) as! ProjectTableViewCell
        cell.backgroundCard.backgroundColor = colors[indexPath.item % colors.count]
        cell.titleLabel.text = projects[indexPath.item].name
        cell.descLabel.text = "Created by: " + String(projects[indexPath.item].createdBy ?? 6)
        cell.numberOfMembersLabel.text = String(7) + " members"
        cell.selectionStyle = .none
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let teamsOverviewCollectionViewController = TeamOverviewCollectionViewController(collectionViewLayout: layout)
        self.navigationController?.pushViewController(teamsOverviewCollectionViewController, animated: true)
    }
    
    

}
