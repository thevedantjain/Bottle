//
//  TeamOverviewCollectionViewController.swift
//  Bottle 2
//
//  Created by Vedant Jain on 06/04/19.
//  Copyright © 2019 Vedant Jain. All rights reserved.
//

import UIKit

// team name + details cell
// slider pane cell
private let detailsCellID = "detailsCellID"
private let sliderPaneCellID = "sliderPaneCellID"

class TeamOverviewCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    fileprivate func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.title = "Team Overview"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        collectionView.backgroundColor = .white
        
        // Register cell classes
        self.collectionView.register(TaskListCollectionViewCell.self, forCellWithReuseIdentifier: sliderPaneCellID)
        
        collectionView.isPagingEnabled = true
        collectionView.contentInset = UIEdgeInsets(top: 260, left: 0, bottom: -16, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 260, left: 0, bottom: 0, right: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupOverviewView()
        setupMenuBar()
    }
    
    let overviewView: TeamOverviewView = {
        let view = TeamOverviewView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = "Team Name"
        view.descLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam non nunc eu sapien consectetur auctor. Donec imperdiet nunc sit amet augue pretium pulvinar."
        view.numberOfMembersLabel.text = "Total members: " + String(8)
        return view
    }()
    
    func setupOverviewView() {
        collectionView.addSubview(overviewView)
        
        overviewView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        overviewView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        overviewView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        overviewView.heightAnchor.constraint(equalToConstant: 220)
    }
    
    lazy var menuBar: MenuBar = {
        let menuBar = MenuBar()
        menuBar.teamOverviewCollectionViewControllerInstance = self
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        return menuBar
    }()
    
    private func setupMenuBar() {
        collectionView.addSubview(menuBar)
        menuBar.topAnchor.constraint(equalTo: overviewView.bottomAnchor, constant: 160).isActive = true
        menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 2
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: sliderPaneCellID, for: indexPath) as! TaskListCollectionViewCell
        cell.teamOverviewCollectionViewControllerInstance = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 500)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 2
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition(), animated: true)
    }

}
