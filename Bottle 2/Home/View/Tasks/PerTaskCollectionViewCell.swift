//
//  PerTaskCollectionViewCell.swift
//  Bottle 2
//
//  Created by Vedant Jain on 08/04/19.
//  Copyright © 2019 Vedant Jain. All rights reserved.
//

import UIKit
private let cellID = "cellID"
private let notaskId = "haha"

class PerTaskCollectionViewCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
    
    var tasks: [Task]?
    var users: [User]?
    var taskByMeBool: Bool?
    var color: UIColor?
    var mainUser: User?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.separatorColor = .white
        return view
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tasks?.isEmpty == true {
            return 1
        }
        else {
            return tasks?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            let complete = self.tasks?[indexPath.item].isComplete
            self.tasks?[indexPath.item].isComplete = complete == 1 ? 0 : 1
            let indexPathArray: [IndexPath] = [indexPath]
            tableView.reloadRows(at: indexPathArray, with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tasks?.isEmpty == true {
            let cell = tableView.dequeueReusableCell(withIdentifier: notaskId, for: indexPath) as! EmptyTableViewCell
            cell.selectionStyle = .none
            return cell
        }
        else {
            let task = tasks?[indexPath.item] ?? Task(id: -1, title: "", createdBy: -1, createdAt: "", updatedAt: "", details: "", isComplete: -1, assignedTo: -1, project: -1, workspace: -1)
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TaskTableViewCell
            cell.titleLabel.text = task.title ?? "Hello"
            if taskByMeBool == true {
                for user in users ?? [] {
                    if task.assignedTo == user.id {
                        // add details
                        print("here")
                        cell.userLabel.text = "Assigned to: " + (user.username ?? "")
                    }
                }
            }
            else {
                // add main user details
                print("here here")
                cell.userLabel.text = "Assigned by: " + (String(task.createdBy ?? -1))
            }
            cell.userLabel.text = "Assigned to: 5"
            cell.detailsLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut fermentum aliquet rutrum. Aenean laoreet viverra augue, id pharetra diam consequat ut."
            cell.isCompletedView.image = task.isComplete == 1 ? UIImage(named: "completed") : UIImage(named: "not_complete")
            cell.backgroundCard.backgroundColor = color
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tasks?.isEmpty == true {
            return 100
        }
        return 170.0
    }
    
    fileprivate func setupTableView() {
        tableView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        tableView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
    
    func setupViews() {

        addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.register(EmptyTableViewCell.self, forCellReuseIdentifier: notaskId)
        
        setupTableView()
        
    }
    
}
