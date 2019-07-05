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
    
    var members: [Int] = []
    let dispatchGroup: DispatchGroup = DispatchGroup()
    
    var tabViewControllerInstance: TabViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Members"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(MemberTableViewCell.self, forCellReuseIdentifier: memberCellID)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        networking(workspace: tabViewControllerInstance?.workspace ?? -1)
        dispatchGroup.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: memberCellID, for: indexPath) as! MemberTableViewCell
        cell.titleLabel.text = "Member ID: " + String(members[indexPath.item])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("selected row : ", String(indexPath.item))
    }
    
    fileprivate func networking(workspace: Int) {
        
        if workspace == -1 {
            print("error -1")
        }
        
        LoadingOverlay.shared.showOverlay(view: self.view)
        dispatchGroup.enter()
        
        let url = "https://j8008zs2ol.execute-api.ap-south-1.amazonaws.com/default/workspaceusers"
        
        let headers = [
            "Content-type": "application/json"
        ]
        
        let parameters = [
            "workspaceId": workspace
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success:
                guard let items = response.result.value as? [[String:AnyObject]] else {
                    return
                }
                for element in items {
                    self.members.append(element["userId"] as! Int)
                }
                self.dispatchGroup.leave()
                LoadingOverlay.shared.hideOverlayView()
                break
            case .failure(let error):
                print(error)
                break
            }
        }
        
    }

}
