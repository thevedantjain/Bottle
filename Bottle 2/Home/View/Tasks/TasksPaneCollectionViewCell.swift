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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
//        view.isPagingEnabled = true
        return view
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! PerTaskCollectionViewCell
        cell.titleLabel.text = indexPath.item % 2 == 0 ? "For Me" : "By Me"
        cell.tasks = indexPath.item % 2 == 0 ? tasksForMe : tasksByMe
        DispatchQueue.main.async {
            cell.tableView.reloadData()
        }
//        cell.backgroundColor = indexPath.item % 2 == 0 ? .red : .green
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 400)
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
    
    fileprivate func setupTitleLabel() {
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    
    fileprivate func setupCollectionView() {
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
    }
    
    func setupViews() {
        
        addSubview(titleLabel)
        
        addSubview(collectionView)
        
        collectionView.register(PerTaskCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupTitleLabel()
        
        setupCollectionView()
        
    }
    
    

    
}
