//
//  TeamDetailsCollectionViewCell.swift
//  Bottle 2
//
//  Created by Vedant Jain on 06/04/19.
//  Copyright © 2019 Vedant Jain. All rights reserved.
//

import UIKit

class TeamDetailsCollectionViewCell: UICollectionViewCell {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    var descLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 8
        return label
    }()
    
    var numberOfMembersLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    fileprivate func setupTitleLabel() {
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
    }
    
    fileprivate func setupNumberOfMembersLabel() {
        numberOfMembersLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        numberOfMembersLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
    }
    
    fileprivate func setupDescLabel() {
        descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        descLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        descLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
    }
    
    func setupViews() {
        
        self.backgroundColor = .white
        
        addSubview(titleLabel)
        setupTitleLabel()
        
        addSubview(descLabel)
        setupDescLabel()
        
        addSubview(numberOfMembersLabel)
        setupNumberOfMembersLabel()
        
    }
    
}
