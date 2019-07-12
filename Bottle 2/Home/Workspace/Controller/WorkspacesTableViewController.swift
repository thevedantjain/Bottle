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
    var workspaces: [Workspace]?
    let colors: [UIColor] = [UIColor(red:0.23, green:0.28, blue:0.93, alpha:0.7), UIColor(red:0.86, green:0.34, blue:0.22, alpha:0.7)]
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
        
        // setup + button for new workspace
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addWorkspace))
        
        tableView.register(WorkspaceTableViewCell.self, forCellReuseIdentifier: cellID)
        
        tableView.separatorStyle = .none
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if workspaces == nil {
            self.dismiss(animated: true, completion: nil)
        }

    }
    
    @objc func addWorkspace() {
        let alertController = UIAlertController(title: "Add workspace", message: "Creating a new workspace.", preferredStyle: .alert)
        
        alertController.addTextField { (textField: UITextField) in
            textField.placeholder = "Workspace Name"
        }
        
        let createAction =  UIAlertAction(title: "Create", style: .default) { (alert) in
            self.createWorkspace(name: alertController.textFields?[0].text ?? "errInPostReq", completion: {
                self.dismiss(animated: true, completion: nil)
            })
        }
        
        let dismissAction = UIAlertAction(title: "Dismiss", style: .destructive, handler: nil)
        
        alertController.addAction(createAction)
        alertController.addAction(dismissAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workspaces?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! WorkspaceTableViewCell
        cell.backgroundCard.backgroundColor = colors[indexPath.item % colors.count]
        cell.titleLabel.text = workspaces?[indexPath.item].name ?? ""
        cell.detailTextLabel?.text = "ID: " + String(workspaces?[indexPath.item].id ?? -1)
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if homeCollectionViewControllerInstance?.tabViewControllerInstance?.workspace?.id == workspaces?[indexPath.item].id ?? -1 {
            self.dismiss(animated: true, completion: nil)
        }
        else {
            homeCollectionViewControllerInstance?.tabViewControllerInstance?.workspace = workspaces?[indexPath.item]
//            UserDefaults.standard.set(workspaces?[indexPath.item], forKey: "selectedWorkspace")
            UserDefaults.standard.set(try? PropertyListEncoder().encode(workspaces?[indexPath.item]), forKey:"selectedWorkspace")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    fileprivate func createWorkspace(name: String, completion: @escaping () -> ()) {
        
        let url = "https://7dq8nzhy1e.execute-api.ap-south-1.amazonaws.com/default/workspace"
        
        let headers = [
            "Content-type": "application/json"
        ]
        
        let parameters: [String: AnyObject] = [
            "name": name as AnyObject,
            "createdBy": homeCollectionViewControllerInstance?.mainUser?.id as AnyObject? ?? -1 as AnyObject
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success:
                // set workspace variable to new workspace
                // add the user to the workspace
                // get workspace data
                self.homeCollectionViewControllerInstance?.tabViewControllerInstance?.workspace = self.workspaces?.first
                completion()
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    fileprivate func getWorkspaceDetails(createdBy: Int, completion: @escaping () -> ()) {
        
        
        
    }

}
