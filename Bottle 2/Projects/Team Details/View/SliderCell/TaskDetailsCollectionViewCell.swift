//
//  TaskDetailsCollectionViewCell.swift
//  Bottle 2
//
//  Created by Vedant Jain on 22/05/19.
//  Copyright © 2019 Vedant Jain. All rights reserved.
//

import UIKit

class TaskDetailsCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let backgroundCard: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.0)
        view.layer.masksToBounds = true
        return view
    }()
    
    let taskTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let deadlineLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate func setupDeadlineLabel() {
        
        deadlineLabel.topAnchor.constraint(equalTo: taskTitleLabel.bottomAnchor, constant: 8).isActive = true
        deadlineLabel.leadingAnchor.constraint(equalTo: backgroundCard.leadingAnchor, constant: 8).isActive = true
        deadlineLabel.trailingAnchor.constraint(equalTo: backgroundCard.trailingAnchor, constant: -8).isActive = true
        deadlineLabel.bottomAnchor.constraint(equalTo: backgroundCard.bottomAnchor).isActive = true
        
    }
    
    fileprivate func setupTaskTitleLabel() {
        
        taskTitleLabel.topAnchor.constraint(equalTo: backgroundCard.topAnchor, constant: 8).isActive = true
        taskTitleLabel.leadingAnchor.constraint(equalTo: backgroundCard.leadingAnchor, constant: 8).isActive = true
        taskTitleLabel.heightAnchor.constraint(equalToConstant: 23).isActive = true
        taskTitleLabel.trailingAnchor.constraint(equalTo: backgroundCard.trailingAnchor, constant: -8).isActive = true
        
    }
    
    fileprivate func setupBackgroundCard() {
    
        backgroundCard.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        backgroundCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        backgroundCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        backgroundCard.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    
    }
    
    func setupViews() {
        
        addSubview(backgroundCard)
        setupBackgroundCard()
        
        addSubview(taskTitleLabel)
        setupTaskTitleLabel()
        
        addSubview(deadlineLabel)
        setupDeadlineLabel()
        
        
    }
    
}
