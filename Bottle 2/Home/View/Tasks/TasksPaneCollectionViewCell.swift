//
//  TasksPaneCollectionViewCell.swift
//  Bottle 2
//
//  Created by Vedant Jain on 06/04/19.
//  Copyright © 2019 Vedant Jain. All rights reserved.
//

import UIKit
import Alamofire

private let cellID = "cellID"

class TasksPaneCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var userId: Int?
    var tasksByMe: [Task]?
    var tasksForMe: [Task]?
    
    let colors: [UIColor] = [UIColor(red:0.23, green:0.28, blue:0.93, alpha:0.7), UIColor(red:0.86, green:0.34, blue:0.22, alpha:0.7)]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 2
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition(), animated: true)
    }
    
    lazy var menuBar: MenuBar = {
        let menuBar = MenuBar()
        menuBar.teamOverviewCollectionViewControllerInstance = nil
        menuBar.tasksPaneCollectionViewInstance = self
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        return menuBar
    }()

    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.isPagingEnabled = true
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return view
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! PerTaskCollectionViewCell
        cell.tasks = indexPath.item % 2 == 0 ? tasksForMe : tasksByMe
        cell.color = colors[indexPath.item % colors.count]
        DispatchQueue.main.async {
            cell.tableView.backgroundColor = .clear
            cell.tableView.reloadData()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: 400)
    }
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 23)
        return label
    }()
    
    var pagingController: UIPageControl = {
        let control = UIPageControl()
        control.numberOfPages = 2
        return control
    }()
    
    private func setupMenuBar() {
        menuBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        menuBar.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        menuBar.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    fileprivate func setupTitleLabel() {
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    
    fileprivate func setupCollectionView() {
        collectionView.topAnchor.constraint(equalTo: menuBar.bottomAnchor, constant: 8).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
    }
    
    func setupViews() {
        
        addSubview(titleLabel)
        setupTitleLabel()
        
        addSubview(menuBar)
        setupMenuBar()
        
        addSubview(collectionView)
        
        collectionView.register(PerTaskCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupCollectionView()
        
    }
    
    

    
}
