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

class TeamsTableViewController: UITableViewController {
    
    let colors: [UIColor] = [UIColor(red:0.23, green:0.28, blue:0.93, alpha:0.7), UIColor(red:0.86, green:0.34, blue:0.22, alpha:0.7), UIColor(red:0.18, green:0.60, blue:0.68, alpha:1.0), UIColor(red:0.89, green:0.56, blue:0.37, alpha:1.0)]
    
    var teams: [String] = []
    
    var tabViewControllerInstance: TabViewController?
    
    let dispatchGroup: DispatchGroup = DispatchGroup()

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

    override func viewDidAppear(_ animated: Bool) {
        self.getProjects(userId: self.tabViewControllerInstance?.userId ?? 6)
        dispatchGroup.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: teamCellID, for: indexPath) as! TeamTableViewCell
        cell.backgroundCard.backgroundColor = colors[indexPath.item % colors.count]
        cell.titleLabel.text = teams[indexPath.item]
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
    
    func getProjects(userId: Int) {
        
        LoadingOverlay.shared.showOverlay(view: self.view)
        
        dispatchGroup.enter()
        
        teams = []
        
        let url = "https://wg9fx8sfq8.execute-api.ap-south-1.amazonaws.com/default/projects"
        
        let parameters = [
            "createdBy": userId
        ]
        
//        let headers = []
        
        Alamofire.request(url, method: .get, parameters: parameters, headers: [:]).responseJSON { (response) in
            switch response.result {
            case .success:
                guard let items = response.result.value as? [[String:AnyObject]] else {return}
                for element in items {
                    self.teams.append(element["name"] as! String)
                }
                self.dispatchGroup.leave()
                LoadingOverlay.shared.hideOverlayView()
                break
            case .failure(let err):
                print(err)
                break
            }
        }
        
    }

}
