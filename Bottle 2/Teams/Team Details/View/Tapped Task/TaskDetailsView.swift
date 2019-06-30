//
//  TaskDetailsView.swift
//  Bottle 2
//
//  Created by Vedant Jain on 22/05/19.
//  Copyright © 2019 Vedant Jain. All rights reserved.
//

import UIKit

class TaskDetailsView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let taskTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let taskDeadlineLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let taskDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate func setupTitleLabel() {
        taskTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        taskTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        taskTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        taskTitleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    fileprivate func setupDeadlineLabel() {
        taskDeadlineLabel.topAnchor.constraint(equalTo: taskTitleLabel.bottomAnchor, constant: 16).isActive = true
        taskDeadlineLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        taskDeadlineLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        taskDeadlineLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    fileprivate func setupTaskDescriptionLabel() {
        taskDescriptionLabel.topAnchor.constraint(equalTo: taskDescriptionLabel.bottomAnchor, constant: 16).isActive = true
        taskDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        taskDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16).isActive = true
        taskDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
    }
    
    func setupViews() {
        addSubview(taskTitleLabel)
        setupTitleLabel()
        
        addSubview(taskDeadlineLabel)
        setupDeadlineLabel()
        
        addSubview(taskDescriptionLabel)
        setupTaskDescriptionLabel()
    }
    
}
