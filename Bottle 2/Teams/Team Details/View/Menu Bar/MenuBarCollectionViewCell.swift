//
//  MenuBarCollectionViewCell.swift
//  Bottle 2
//
//  Created by Vedant Jain on 22/05/19.
//  Copyright © 2019 Vedant Jain. All rights reserved.
//

import UIKit

class MenuBarCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let taskTypeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate func setupDayLabel() {
        taskTypeLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        taskTypeLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        taskTypeLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        taskTypeLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupViews() {
        addSubview(taskTypeLabel)
        setupDayLabel()
        
    }
    
}
