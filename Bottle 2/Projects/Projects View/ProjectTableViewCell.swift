//
//  TeamTableViewCell.swift
//  Bottle 2
//
//  Created by Vedant Jain on 06/04/19.
//  Copyright © 2019 Vedant Jain. All rights reserved.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        setupViews()
    }
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    var descLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 8
        label.textColor = .white
        return label
    }()
    
    var numberOfMembersLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    var backgroundCard: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    fileprivate func setupBackgroundCard() {
        backgroundCard.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        backgroundCard.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        backgroundCard.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        backgroundCard.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
    
    fileprivate func setupTitleLabel() {
        titleLabel.topAnchor.constraint(equalTo: backgroundCard.topAnchor, constant: 16).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: backgroundCard.leftAnchor, constant: 16).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: backgroundCard.rightAnchor, constant: -16).isActive = true
    }
    
    fileprivate func setupDescLabel() {
        descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        descLabel.leftAnchor.constraint(equalTo: backgroundCard.leftAnchor, constant: 16).isActive = true
        descLabel.rightAnchor.constraint(equalTo: backgroundCard.rightAnchor, constant: -16).isActive = true
    }
    
    fileprivate func setupNumberOfMembersLabel() {
        numberOfMembersLabel.bottomAnchor.constraint(equalTo: backgroundCard.bottomAnchor, constant: -16).isActive = true
        numberOfMembersLabel.rightAnchor.constraint(equalTo: backgroundCard.rightAnchor, constant: -16).isActive = true
    }
    
    func setupViews() {
        
        addSubview(backgroundCard)
        setupBackgroundCard()
        
        addSubview(titleLabel)
        setupTitleLabel()
        
        addSubview(descLabel)
        setupDescLabel()
        
        addSubview(numberOfMembersLabel)
        setupNumberOfMembersLabel()
        
    }
}
