//
//  TabViewController.swift
//  Bottle 2
//
//  Created by Vedant Jain on 06/04/19.
//  Copyright © 2019 Vedant Jain. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController {
    
    var workspace: Workspace? = Workspace(id: -1, createdBy: -1, createdAt: "", updatedAt: "")
    var userId: Int? = 6
    var users: [User] = []
    
    // 0 - no new changes
    // 1 - workspace changed
    // 2 - new workspace added;
    //
    var state: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isTranslucent = true
        
        //home page
        let homeCollectionViewController = HomeCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let homeNavigationController = UINavigationController(rootViewController: homeCollectionViewController)
        homeCollectionViewController.tabViewControllerInstance = self
        homeNavigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), tag: 0)
        
        //teams
        let projectsTableViewController = ProjectsTableViewController()
        let projectsNavigationController = UINavigationController(rootViewController: projectsTableViewController)
        projectsTableViewController.homeCollectionViewControllerInstance = homeCollectionViewController
        projectsNavigationController.tabBarItem = UITabBarItem(title: "Projects", image: UIImage(named: "projects"), tag: 1)
        
        //members
        let membersTableViewController = MembersTableViewController()
        let membersNavigationController = UINavigationController(rootViewController: membersTableViewController)
        membersTableViewController.tabViewControllerInstance = self
        membersNavigationController.tabBarItem = UITabBarItem(title: "Members", image: UIImage(named: "members"), tag: 2)

        //add to tab bar
        viewControllers = [homeNavigationController, projectsNavigationController, membersNavigationController]
    }

}
