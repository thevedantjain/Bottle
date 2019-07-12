//
//  TaskListCollectionViewCell.swift
//  Bottle 2
//
//  Created by Vedant Jain on 22/05/19.
//  Copyright © 2019 Vedant Jain. All rights reserved.
//

import UIKit

private let cellID = "cellID"

class TaskListCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var teamOverviewCollectionViewControllerInstance: TeamOverviewCollectionViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.register(TaskDetailsCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        cv.backgroundColor = .white
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! TaskDetailsCollectionViewCell
        cell.taskTitleLabel.text = "Task Name"
        cell.deadlineLabel.text = "12/12/20"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tappedViewController = TaskDetailsViewController()
        tappedViewController.taskTitleLabel.text = "Task Title"
        tappedViewController.taskDeadlineLabel.text = "12/12/20"
        tappedViewController.taskDescriptionLabel.text = "Lorem ipsum \n can go \n upto \n 8 lines \n my guys"
        teamOverviewCollectionViewControllerInstance?.navigationController?.present(tappedViewController, animated: true, completion: nil)
    }
    
    fileprivate func setupCollectionView() {
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func setupViews() {
        
        addSubview(collectionView)
        setupCollectionView()
        
    }
    
}
