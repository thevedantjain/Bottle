//
//  MenuBar.swift
//  Bottle 2
//
//  Created by Vedant Jain on 22/05/19.
//  Copyright © 2019 Vedant Jain. All rights reserved.
//

import UIKit

private let cellID = "cellID"

class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var teamOverviewCollectionViewControllerInstance: TeamOverviewCollectionViewController?
    var tasksPaneCollectionViewInstance: TasksPaneCollectionViewCell?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white // nav bar's translucent colour: UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1.0)
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MenuBarCollectionViewCell
        cell.taskTypeLabel.text = (indexPath.item % 2 == 0) ? "For Me" : "By Me"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width/2, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        teamOverviewCollectionViewControllerInstance?.scrollToMenuIndex(menuIndex: indexPath.item)
        tasksPaneCollectionViewInstance?.scrollToMenuIndex(menuIndex: indexPath.item)
    }
    
    fileprivate func setupCollectionView() {
        collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.register(MenuBarCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        addSubview(collectionView)
        setupCollectionView()
        
        //select item 1 on startup
        let selectedItemPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedItemPath, animated: false, scrollPosition: UICollectionView.ScrollPosition())
        
        setupHorizontalBar()
    }
    
    var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    
    func setupHorizontalBar() {
        
        let horizontalBar: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        let backgroundCard: UIView = {
            let view = UIView()
            view.layer.cornerRadius = 10
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = UIColor(white: 0, alpha: 0.1)
            view.layer.masksToBounds = true
            return view
        }()
        
        horizontalBar.addSubview(backgroundCard)
        backgroundCard.topAnchor.constraint(equalTo: horizontalBar.topAnchor, constant: 6).isActive = true
        backgroundCard.leadingAnchor.constraint(equalTo: horizontalBar.leadingAnchor, constant: 8).isActive = true
        backgroundCard.trailingAnchor.constraint(equalTo: horizontalBar.trailingAnchor, constant: -8).isActive = true
        backgroundCard.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.addSubview(horizontalBar)
        horizontalBar.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontalBarLeftAnchorConstraint = horizontalBar.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalBarLeftAnchorConstraint?.isActive = true
        horizontalBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        horizontalBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
