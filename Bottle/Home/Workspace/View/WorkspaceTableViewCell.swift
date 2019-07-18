//
//  WorkspaceTableViewCell.swift
//  Bottle 2
//
//  Created by Vedant Jain on 28/06/19.
//  Copyright © 2019 Vedant Jain. All rights reserved.
//

import UIKit

class WorkspaceTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupViews()
    }
    
    let backgroundCard: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate func setupBackgroundCard() {
        backgroundCard.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        backgroundCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        backgroundCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        backgroundCard.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
    }
    
    fileprivate func setupTitleLabel() {
        titleLabel.topAnchor.constraint(equalTo: backgroundCard.topAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: backgroundCard.leadingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: backgroundCard.trailingAnchor, constant: -8).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: backgroundCard.bottomAnchor, constant: -8).isActive = true
    }
    
    func setupViews() {
        addSubview(backgroundCard)
        setupBackgroundCard()
        
        addSubview(titleLabel)
        setupTitleLabel()
    }

}
