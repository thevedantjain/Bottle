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
    
    var workspaces: [Workspace] = []
    var users: [User] = []
    var projects: [Project] = []
    
    var mainUser: User?
    
//    let userDispatch: DispatchGroup = DispatchGroup()
    let dispatchGroup: DispatchGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // to detect shake gesture
        self.becomeFirstResponder()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView!.register(StatsCollectionViewCell.self, forCellWithReuseIdentifier: statsCellID)
        collectionView.register(TasksPaneCollectionViewCell.self, forCellWithReuseIdentifier: tasksPaneCellID)
        
        collectionView.backgroundColor = .white
        
        // Register cell classes
        
        
        self.title = "User"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addTask))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(self.openWorkspaceView))

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if UserDefaults.standard.object(forKey: "userLogin") != nil {
            // already used
            let loggedIn = UserDefaults.standard.bool(forKey: "userLogin")
            if loggedIn == true {
                
                if UserDefaults.standard.object(forKey: "selectedWorkspace") == nil {
                    getWorkspaces(userId: self.tabViewControllerInstance?.userId ?? 6) { (workspacesArray) in
                        self.workspaces = workspacesArray
                        self.openWorkspaceView()
                    }
                }
                
                else {
                    reloadData()
                }
                
                self.title = UserDefaults.standard.string(forKey: "username") ?? "User"
                
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
    
    lazy var formLauncher: TasksFormLauncher = {
        let launcher = TasksFormLauncher()
        launcher.formView.homeCollectionViewControllerInstance = self
        return launcher
    }()
    
    @objc func addTask() {
        
        // take input (make a new view?)
        // add tasks to projects parameters: title, createdBy, workspace, details, assignedTo, project
        // send get request to get taskId (will have to loop through response and search with title
        // need to add tasks to projects separately
        self.formLauncher.setupViews {
            self.formLauncher.animate()
        }
    
    }
    
    @objc func openWorkspaceView() {
        let workspaceViewController = WorkspacesTableViewController()
        let workspaceNavigationController = UINavigationController(rootViewController: workspaceViewController)
        workspaceViewController.homeCollectionViewControllerInstance = self
        workspaceViewController.workspaces = self.workspaces
        self.present(workspaceNavigationController, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    // to detect shake gesture
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    // shake gesture
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            reloadData()
        }
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
            cell.users = self.users
            cell.tasksByMe = tasksByMe
            cell.tasksForMe = tasksForMe
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
        return UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
    }
    
    fileprivate func reloadData() {
        networking(userId: self.tabViewControllerInstance?.userId ?? 6, workspaceId: tabViewControllerInstance?.workspace?.id ?? 1) {
            self.collectionView.reloadData()
        }
    }
    
}
