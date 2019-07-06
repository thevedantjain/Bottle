//
//  TaskTableViewCell.swift
//  Bottle 2
//
//  Created by Vedant Jain on 08/04/19.
//  Copyright © 2019 Vedant Jain. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

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
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    let backgroundCard: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    fileprivate func setupBackgroundCard() {
        backgroundCard.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        backgroundCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        backgroundCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        backgroundCard.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true
    }
    
    fileprivate func setupTitleLabel() {
        titleLabel.topAnchor.constraint(equalTo: backgroundCard.topAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: backgroundCard.leadingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: backgroundCard.trailingAnchor, constant: 0).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 23).isActive = true
    }
    
    func setupViews() {
        
        addSubview(backgroundCard)
        setupBackgroundCard()
    
        addSubview(titleLabel)
        setupTitleLabel()
        
    }
    
}
