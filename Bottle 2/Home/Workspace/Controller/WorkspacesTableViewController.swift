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
    var userId: Int?
    var workspaces: [Int] = []
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.getWorkspaces(userId: self.userId ?? -1)
        }
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.getWorkspaces(userId: self.userId ?? -1)
        }
        tableView.reloadData()
        
        self.title = "Workspaces"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(MemberTableViewCell.self, forCellReuseIdentifier: cellID)

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workspaces.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! MemberTableViewCell
        cell.titleLabel.text = "Workspace " + String(workspaces[indexPath.item])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        homeCollectionViewControllerInstance?.tabViewControllerInstance?.workspace = workspaces[indexPath.item]
        self.dismiss(animated: true, completion: nil)
    }
    
    func getWorkspaces(userId: Int) {
        
        let url = "https://j8008zs2ol.execute-api.ap-south-1.amazonaws.com/default/workspaceusers"
        
        let parameters = [
            "userId": userId
        ]
        
        let header = [
            "Content-Type": "application/json"
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters, headers: header).responseJSON { (response) in
            switch response.result {
            case .success:
                guard let items = response.result.value as? [[String:AnyObject]] else {
                    return
                }
                for element in items {
                    self.workspaces.append(element["workspaceId"] as! Int)
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
        
//        Alamofire.request(url, method: .get, parameters: [:], headers: header).responseJSON{ response in
//            switch response.result {
//            case .success:
//                guard let items = response.result.value as? [[String:AnyObject]] else {
//                    return
//                }
//                for element in items {
//                    if (element["username"] as! String) == username {
//                        UserDefaults.standard.set(true, forKey: "userLogin")
//                        UserDefaults.standard.set(username, forKey: "username")
//                        self.dismiss(animated: true, completion: nil)
//                    }
//                }
//                // user does not exist
//                self.handleMessage(title: "Please register")
//                break
//            case .failure(let error):
//                self.handleMessage(title: "User already exists.")
//                print(error)
//            }
//        }
        
    }

}
