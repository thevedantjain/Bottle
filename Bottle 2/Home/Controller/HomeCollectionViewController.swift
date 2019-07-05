//
//  HomeCollectionViewController.swift
//  Bottle 2
//
//  Created by Vedant Jain on 06/04/19.
//  Copyright © 2019 Vedant Jain. All rights reserved.
//

import UIKit
import Alamofire

private let statsCellID = "statsCellID"
private let tasksPaneCellID = "tasksPaneCellID"

class HomeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var tabViewControllerInstance: TabViewController?
    
    var tasksByMe: [Task] = []
    var tasksForMe: [Task] = []
    
    var workspaces: [Int] = []
    
    let dispatchGroup: DispatchGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .white
        
        // Register cell classes
        self.collectionView!.register(StatsCollectionViewCell.self, forCellWithReuseIdentifier: statsCellID)
        self.collectionView.register(TasksPaneCollectionViewCell.self, forCellWithReuseIdentifier: tasksPaneCellID)
        
        self.title = "User"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(openWorkspaceView))
        
        collectionView.delegate = self
        collectionView.dataSource = self

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if UserDefaults.standard.object(forKey: "userLogin") != nil {
            // already used
            let loggedIn = UserDefaults.standard.bool(forKey: "userLogin")
            if loggedIn == true {
                
                networking(userId: self.tabViewControllerInstance?.userId ?? 6)
                
                dispatchGroup.notify(queue: .main) {
                    if UserDefaults.standard.object(forKey: "selectedWorkspace") == nil {
                        print("print", self.workspaces)
                        self.openWorkspaceView()
                    }
                    self.collectionView.reloadData()
                }
                
                // get workspace
                
                
                tabViewControllerInstance?.workspace = UserDefaults.standard.integer(forKey: "selectedWorkspace")
                
                // do something
                self.title = UserDefaults.standard.string(forKey: "username") ?? "User"
                // load new workspace contents
//
//                DispatchQueue.main.async {
//                    self.collectionView.reloadData()
//                }
                
            }
            else {
                presentLoginController()
            }
        }
        else {
            // app opened for the first time
            UserDefaults.standard.set(false, forKey: "userLogin")
            presentLoginController()
        }
    }
    
    func presentLoginController() {
        let loginViewController = LoginViewController()
        self.present(loginViewController, animated: true, completion: nil)
    }
    
    
    @objc func addTask() {
        print("add task")
    }
    
    @objc func openWorkspaceView() {
        let workspaceViewController = WorkspacesTableViewController()
        let workspaceNavigationController = UINavigationController(rootViewController: workspaceViewController)
//        self.navigationController?.pushViewController(workspaceViewController, animated: true)
        workspaceViewController.homeCollectionViewControllerInstance = self
        workspaceViewController.workspaces = self.workspaces
        self.present(workspaceNavigationController, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        // 2 (1 stats cell, 1 tasks cell)
        return 2
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: statsCellID, for: indexPath) as! StatsCollectionViewCell
            cell.titleLabel.text = "Stats"
            cell.subtitleLabel.text = ""
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tasksPaneCellID, for: indexPath) as! TasksPaneCollectionViewCell
            cell.userId = self.tabViewControllerInstance?.userId ?? 6
            cell.titleLabel.text = "Tasks"
            cell.tasksForMe = self.tasksForMe
            cell.tasksByMe = self.tasksByMe
            DispatchQueue.main.async {
                cell.collectionView.reloadData()
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            //stats
            return CGSize(width: view.frame.width, height: 250)
        }
        else {
            // tasks pane
            return CGSize(width: view.frame.width, height: 500)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    private func networking(userId: Int) {
        
        LoadingOverlay.shared.showOverlay(view: self.view)
        
        dispatchGroup.enter()
        
        tasksForMe = []
        tasksByMe = []
        
        var url = "https://wa01k4ful5.execute-api.ap-south-1.amazonaws.com/default/tasks"
        
        // goes into tasksbyme
        var parameters = [
            "createdBy": userId
        ]
        
        var header = [
            "Content-Type": "application/json"
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters, headers: header).responseJSON { (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                        let response = try JSONDecoder().decode([Task].self, from: data)
                        for element in response {
                            self.tasksByMe.append(element)
                        }
                    }
                    
                    catch let error {
                        print("error", error)
                    }
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
        
        // goes into tasksForMe
        parameters = [
            "assignedTo": userId
        ]
        
        header = [
            "Content-Type": "application/json"
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters, headers: header).responseJSON { (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                        let response = try JSONDecoder().decode([Task].self, from: data)
                        for element in response {
                            self.tasksByMe.append(element)
                        }
                    }
                        
                    catch let error {
                        print(error)
                    }
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
        
        workspaces = []
        
        url = "https://j8008zs2ol.execute-api.ap-south-1.amazonaws.com/default/workspaceusers"
        
        parameters = [
            "userId": userId
        ]
        
        header = [
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
