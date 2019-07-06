//
//  WorkspacesTableViewController.swift
//  Bottle 2
//
//  Created by Vedant Jain on 28/06/19.
//  Copyright © 2019 Vedant Jain. All rights reserved.
//

import UIKit
import Alamofire

private let cellID = "cellID"

class WorkspacesTableViewController: UITableViewController {
    
    var homeCollectionViewControllerInstance: HomeCollectionViewController?
    var workspaces: [Int]?
//
//    override func viewDidAppear(_ animated: Bool) {
//        DispatchQueue.main.async {
//
//        }
//        tableView.reloadData()
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Workspaces"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(MemberTableViewCell.self, forCellReuseIdentifier: cellID)
        
        if workspaces == nil {
            self.dismiss(animated: true, completion: nil)
        }

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workspaces?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! MemberTableViewCell
        cell.titleLabel.text = "Workspace " + String(workspaces?[indexPath.item] ?? -1)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if homeCollectionViewControllerInstance?.tabViewControllerInstance?.workspace == workspaces?[indexPath.item] ?? -1 {
            self.dismiss(animated: true, completion: nil)
        }
        else {
            homeCollectionViewControllerInstance?.tabViewControllerInstance?.workspace = workspaces?[indexPath.item] ?? -1
            homeCollectionViewControllerInstance?.tabViewControllerInstance?.changesOccurred = true
            UserDefaults.standard.set(workspaces?[indexPath.item] ?? -1, forKey: "selectedWorkspace")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    

}
