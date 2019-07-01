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
    
    var teams: [String] = []
    
    var tabViewControllerInstance: TabViewController?

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
        DispatchQueue.main.async {
            self.getProjects(userId: self.tabViewControllerInstance?.userId ?? 6)
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: teamCellID, for: indexPath) as! TeamTableViewCell
        cell.backgroundCard.backgroundColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.0)
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
        
        let url = "https://wg9fx8sfq8.execute-api.ap-south-1.amazonaws.com/default/projects"
        
        let parameters = [
            "createdBy": userId
        ]
        
        let header = [
            "Content-type": "application/json"
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters, headers: header).responseJSON { (response) in
            switch response.result {
            case .success:
                guard let items = response.result.value as? [[String:AnyObject]] else {return}
                for element in items {
                    self.teams.append(element["name"] as! String)
                }
                break
            case .failure:
                break
            }
        }
        
    }

}
