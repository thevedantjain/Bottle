//
//  TabViewController.swift
//  Bottle 2
//
//  Created by Vedant Jain on 06/04/19.
//  Copyright © 2019 Vedant Jain. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController {
    
    var workspace = 1
    var userId = 6
    var changesOccurred: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isTranslucent = true
        
        //home page
        let homeCollectionViewController = HomeCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let homeNavigationController = UINavigationController(rootViewController: homeCollectionViewController)
        homeCollectionViewController.tabViewControllerInstance = self
        homeNavigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), tag: 0)
        
        //teams
        let teamsTableViewController = TeamsTableViewController()
        let teamNavigationController = UINavigationController(rootViewController: teamsTableViewController)
        teamsTableViewController.tabViewControllerInstance = self
        teamNavigationController.tabBarItem = UITabBarItem(title: "Teams", image: UIImage(named: "teams"), tag: 1)
        
        //members
        let membersTableViewController = MembersTableViewController()
        let membersNavigationController = UINavigationController(rootViewController: membersTableViewController)
        membersTableViewController.tabViewControllerInstance = self
        membersNavigationController.tabBarItem = UITabBarItem(title: "Members", image: UIImage(named: "members"), tag: 2)

        //add to tab bar
        viewControllers = [homeNavigationController, teamNavigationController, membersNavigationController]
    }

}
