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
    var users: [User] = []
    
    var mainUser: User?
    
//    let userDispatch: DispatchGroup = DispatchGroup()
    let dispatchGroup: DispatchGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .white
        
        // Register cell classes
        self.collectionView!.register(StatsCollectionViewCell.self, forCellWithReuseIdentifier: statsCellID)
        self.collectionView.register(TasksPaneCollectionViewCell.self, forCellWithReuseIdentifier: tasksPaneCellID)
        
        self.title = "User"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(addTask))
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
                
                if tabViewControllerInstance?.state == 2 {
                    // new workspace has been added.
                    // send another get request to get details, set it as active workspace
                    getWorkspaces(userId: self.tabViewControllerInstance?.userId ?? 6)
                    self.tabViewControllerInstance?.workspace = workspaces.last ?? -1
                    print(self.tabViewControllerInstance?.workspace ?? -1)
                }
                
                // minimize network calls
                // only call if some change has occurred
                if tabViewControllerInstance?.state ?? 1 != 0 || tasksByMe.isEmpty == true || tasksForMe.isEmpty == true {
                    networking(userId: self.tabViewControllerInstance?.userId ?? 6, workspaceId: tabViewControllerInstance?.workspace ?? 1)
                    
                    dispatchGroup.notify(queue: .main) {
                        if UserDefaults.standard.object(forKey: "selectedWorkspace") == nil {
                            self.openWorkspaceView()
                        }
                        self.collectionView.reloadData()
                    }
                    
                    tabViewControllerInstance?.workspace = UserDefaults.standard.integer(forKey: "selectedWorkspace")
                    
                    self.title = UserDefaults.standard.string(forKey: "username") ?? "User"
                    
                    tabViewControllerInstance?.state = 0
                }
                
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
        networking(userId: self.tabViewControllerInstance?.userId ?? 6, workspaceId: tabViewControllerInstance?.workspace ?? 1)
        
        dispatchGroup.notify(queue: .main) {
            if UserDefaults.standard.object(forKey: "selectedWorkspace") == nil {
                self.openWorkspaceView()
            }
            self.collectionView.reloadData()
        }
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
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE, MMMM dd"
            cell.subtitleLabel.text = dateFormatter.string(from: Date())
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tasksPaneCellID, for: indexPath) as! TasksPaneCollectionViewCell
            cell.userId = self.tabViewControllerInstance?.userId ?? 6
            cell.titleLabel.text = "Tasks"
            cell.tasksForMe = self.tasksForMe
            cell.tasksByMe = self.tasksByMe
            cell.users = self.users
            cell.mainUser = mainUser
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
    
    private func networking(userId: Int, workspaceId: Int) {
        
        dispatchGroup.enter()
        
        getTasksByMe(userId: userId) { (tasks) in
            self.tasksByMe = tasks
        }
        
        getTasksForMe(userId: userId) { (tasks) in
            self.tasksForMe = tasks
        }
        
        getWorkspaces(userId: userId)
        
        getUsers(workspaceId: workspaceId) { () in
            print(self.users)
            self.tabViewControllerInstance?.users = self.users
        }
        
        dispatchGroup.leave()
        
    }
    
    private func getUsers(workspaceId: Int, completion: @escaping () -> ()) {
        
        // get list of users in workspace
        // use userIds to get details of each user
        
        LoadingOverlay.shared.showOverlay(view: self.view)
        
        let url = "https://j8008zs2ol.execute-api.ap-south-1.amazonaws.com/default/workspaceusers"

        let parameters = [
            "workspaceId": workspaceId
        ]

        let headers = [
            "Content-type": "application/json"
        ]
        
        users = []
        
        Alamofire.request(url, method: .get, parameters: parameters, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                        let response = try JSONDecoder().decode([WorkspaceUser].self, from: data)
                        for element in response {
                            self.getUserDetails(userId: element.userId!, completion: { (user) in
                                self.users.append(user)
                                if user.id! == self.tabViewControllerInstance?.userId! {
                                    self.mainUser = user
                                }
                            })
                        }
                        LoadingOverlay.shared.hideOverlayView()
                    }
                    catch let error {
                        print("error", error)
                    }
                    print("wtf", self.users)
                    completion()
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
        
    }
    
    private func getUserDetails(userId: Int, completion: @escaping (User) -> ()){
        
        if userId == -1 {print("err")}
        
        let url = "https://qkvee3o84e.execute-api.ap-south-1.amazonaws.com/default/getusers"
        
        let headers = [
            "Content-type": "application/json"
        ]
        
        let parameters = [
            "id": userId
        ]
        
        var userDetails: User?
        
        Alamofire.request(url, method: .get, parameters: parameters, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                        let response = try JSONDecoder().decode([User].self, from: data)
                        for user in response {
                            // only one element
                            userDetails = User(id: user.id, username: user.username, createdAt: user.createdAt, updatedAt: user.updatedAt)
                            completion(userDetails!)
                        }
                    }
                    catch let error {
                        print("error", error)
                    }
                    LoadingOverlay.shared.hideOverlayView()
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    private func getTasksForMe(userId: Int, completion: @escaping ([Task]) -> ()) {
        
        LoadingOverlay.shared.showOverlay(view: self.view)
        
        var tasks: [Task] = []
        
        let url = "https://wa01k4ful5.execute-api.ap-south-1.amazonaws.com/default/tasks"
        
        // goes into tasksforme
        let parameters = [
            "assignedTo": userId
        ]
        
        let header = [
            "Content-Type": "application/json"
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters, headers: header).responseJSON { (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                        let response = try JSONDecoder().decode([Task].self, from: data)
                        for element in response {
                            tasks.append(element)
                        }
                        completion(tasks)
                    }
                    catch let error {
                        print("error", error)
                    }
                    LoadingOverlay.shared.hideOverlayView()
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
        
    }
    
    private func getTasksByMe(userId: Int, completion: @escaping ([Task]) -> ()) {
        
        LoadingOverlay.shared.showOverlay(view: self.view)
        
        var tasks: [Task] = []
        
        let url = "https://wa01k4ful5.execute-api.ap-south-1.amazonaws.com/default/tasks"
        
        // goes into tasksbyme
        let parameters = [
            "createdBy": userId
        ]
        
        let header = [
            "Content-Type": "application/json"
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters, headers: header).responseJSON { (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                        let response = try JSONDecoder().decode([Task].self, from: data)
                        for element in response {
                            tasks.append(element)
                        }
                        completion(tasks)
                    }
                    catch let error {
                        print("error", error)
                    }
                    LoadingOverlay.shared.hideOverlayView()
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
        
    }
    
    private func getWorkspaces(userId: Int) {
        
        LoadingOverlay.shared.showOverlay(view: self.view)
        
        workspaces = []
        
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
                LoadingOverlay.shared.hideOverlayView()
                break
            case .failure(let error):
                print(error)
                break
            }
        }
        
    }
    
}
