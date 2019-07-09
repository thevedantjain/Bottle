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
        
        // setup + button for new workspace
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addWorkspace))
        
        tableView.register(MemberTableViewCell.self, forCellReuseIdentifier: cellID)
        
        if workspaces == nil {
            self.dismiss(animated: true, completion: nil)
        }

    }
    
    @objc func addWorkspace() {
        print("Adding new workspace")
        let alertController = UIAlertController(title: "Add workspace", message: "Creating a new workspace.", preferredStyle: .alert)
        
        alertController.addTextField { (textField: UITextField) in
            textField.placeholder = "Workspace Name"
        }
        
        let createAction =  UIAlertAction(title: "Create", style: .default) { (alert) in
            self.createWorkspace(name: alertController.textFields?[0].text ?? "errInPostReq")
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
            homeCollectionViewControllerInstance?.tabViewControllerInstance?.state = 1
            UserDefaults.standard.set(workspaces?[indexPath.item] ?? -1, forKey: "selectedWorkspace")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    fileprivate func createWorkspace(name: String) {
        
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
                print(response.result.value)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
        
        homeCollectionViewControllerInstance?.tabViewControllerInstance?.state = 2
        self.dismiss(animated: true, completion: nil)
        
    }

}
