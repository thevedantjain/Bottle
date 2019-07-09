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
        label.font = UIFont.systemFont(ofSize: 23)
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
    
    let userLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    let detailsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 5
        return label
    }()
    
    let isCompletedView: UIImageView = {
        let frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        let view = UIImageView(frame: frame)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    fileprivate func setupBackgroundCard() {
        backgroundCard.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        backgroundCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        backgroundCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        backgroundCard.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true
    }
    
    fileprivate func setupTitleLabel() {
        titleLabel.topAnchor.constraint(equalTo: backgroundCard.topAnchor, constant: 16).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: backgroundCard.leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: backgroundCard.trailingAnchor, constant: 0).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 23).isActive = true
    }
    
    fileprivate func setupUserLabel() {
        userLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        userLabel.leadingAnchor.constraint(equalTo: backgroundCard.leadingAnchor, constant: 16).isActive = true
        userLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        userLabel.heightAnchor.constraint(equalToConstant: 23).isActive = true
    }
    
    fileprivate func setupIsCompletedView() {
        isCompletedView.topAnchor.constraint(equalTo: backgroundCard.topAnchor, constant: 16).isActive = true
        isCompletedView.trailingAnchor.constraint(equalTo: backgroundCard.trailingAnchor, constant: -16).isActive = true
        isCompletedView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        isCompletedView.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    fileprivate func setupDetailsLabel() {
        detailsLabel.topAnchor.constraint(equalTo: userLabel.bottomAnchor, constant: -8).isActive = true
        detailsLabel.leadingAnchor.constraint(equalTo: backgroundCard.leadingAnchor, constant: 16).isActive = true
        detailsLabel.trailingAnchor.constraint(equalTo: backgroundCard.trailingAnchor, constant: -16).isActive = true
        detailsLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func setupViews() {
        
        addSubview(backgroundCard)
        setupBackgroundCard()
        
        addSubview(titleLabel)
        setupTitleLabel()
        
        addSubview(userLabel)
        setupUserLabel()
        
        addSubview(detailsLabel)
        setupDetailsLabel()
        
        addSubview(isCompletedView)
        setupIsCompletedView()
        
    }
    
}
