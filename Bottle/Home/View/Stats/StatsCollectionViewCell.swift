//
//  StatsCollectionViewCell.swift
//  Bottle 2
//
//  Created by Vedant Jain on 06/04/19.
//  Copyright © 2019 Vedant Jain. All rights reserved.
//

import UIKit
import Alamofire

private let statCellID = "statCellID"

class StatsCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let colors: [UIColor] = [UIColor(red:0.23, green:0.28, blue:0.93, alpha:0.7), UIColor(red:0.86, green:0.34, blue:0.22, alpha:0.7), UIColor(red:0.18, green:0.60, blue:0.68, alpha:1.0), UIColor(red:0.89, green:0.56, blue:0.37, alpha:1.0)]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let cellCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cellCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cellCollectionView.showsHorizontalScrollIndicator = false
        cellCollectionView.backgroundColor = .white
        cellCollectionView.translatesAutoresizingMaskIntoConstraints = false
        return cellCollectionView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    fileprivate func setupTitleLabel() {
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
    }
    
    fileprivate func setupSubtitleLabel() {
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        subtitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        subtitleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        subtitleLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
    }
    
    fileprivate func setupCellCollectionView() {
        cellCollectionView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 8).isActive = true
        cellCollectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        cellCollectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        cellCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func setupViews() {
        addSubview(titleLabel)
        setupTitleLabel()
        
        addSubview(subtitleLabel)
        setupSubtitleLabel()
        
        addSubview(cellCollectionView)
        setupCellCollectionView()
        
        cellCollectionView.dataSource = self
        cellCollectionView.delegate = self
        cellCollectionView.register(PerStatCollectionViewCell.self, forCellWithReuseIdentifier: statCellID)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cellCollectionView.dequeueReusableCell(withReuseIdentifier: statCellID, for: indexPath) as! PerStatCollectionViewCell
        cell.backgroundCard.backgroundColor = colors[indexPath.item % colors.count]
        cell.titleLabel.text = "Title"
        cell.bodyLabel.text = "Body text haha haha"
        cell.progressLabel.text = String(75)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 150)
    }
    
}
