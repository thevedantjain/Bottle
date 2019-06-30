//
//  PerStatCollectionViewCell.swift
//  Bottle 2
//
//  Created by Vedant Jain on 06/04/19.
//  Copyright © 2019 Vedant Jain. All rights reserved.
//

import UIKit

class PerStatCollectionViewCell: UICollectionViewCell {
    
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
        view.layer.masksToBounds = true
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let progressLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .black
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    func setupViews() {
        
        addSubview(backgroundCard)
        setupBackgroundCard()
        
        addSubview(titleLabel)
        setupTitleLabel()
        
        addSubview(bodyLabel)
        setupBodyLabel()
        
        addSubview(progressLabel)
        setupProgressLabel()
        
    }
    
    fileprivate func setupBackgroundCard() {
        backgroundCard.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        backgroundCard.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        backgroundCard.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        backgroundCard.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
    }
    
    fileprivate func setupTitleLabel() {
        titleLabel.topAnchor.constraint(equalTo: backgroundCard.topAnchor, constant: 16).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: backgroundCard.leftAnchor, constant: 16).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: backgroundCard.rightAnchor, constant: -16).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    fileprivate func setupBodyLabel() {
        bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2).isActive = true
        bodyLabel.leftAnchor.constraint(equalTo: backgroundCard.leftAnchor, constant: 16).isActive = true
        bodyLabel.rightAnchor.constraint(equalTo: backgroundCard.rightAnchor, constant: -16).isActive = true
        bodyLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    fileprivate func setupProgressLabel() {
        progressLabel.bottomAnchor.constraint(equalTo: backgroundCard.bottomAnchor, constant: -16).isActive = true
        progressLabel.rightAnchor.constraint(equalTo: backgroundCard.rightAnchor, constant: -16).isActive = true
    }
    
}
