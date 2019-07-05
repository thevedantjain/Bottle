//
//  PerTaskCollectionViewCell.swift
//  Bottle 2
//
//  Created by Vedant Jain on 08/04/19.
//  Copyright © 2019 Vedant Jain. All rights reserved.
//

import UIKit
private let cellID = "cellID"

class PerTaskCollectionViewCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
    
    var tasks: [Task]?
    
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
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.separatorColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1.0)
        view.backgroundColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.0)
        return view
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapepd item ", String(indexPath.item))
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TaskTableViewCell
        cell.titleLabel.text = tasks?[indexPath.item].title ?? "Hello"
        cell.selectionStyle = .none
        return cell
    }
    
    
    fileprivate func setupBackgroundCard() {
        backgroundCard.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        backgroundCard.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        backgroundCard.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        backgroundCard.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
    
    fileprivate func setupTitleLabel() {
        titleLabel.topAnchor.constraint(equalTo: backgroundCard.topAnchor, constant: 16).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: backgroundCard.leftAnchor, constant: 16).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: backgroundCard.rightAnchor, constant: -16).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 23).isActive = true
    }
    
    fileprivate func setupTableView() {
        tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        tableView.leftAnchor.constraint(equalTo: backgroundCard.leftAnchor, constant: 16).isActive = true
        tableView.rightAnchor.constraint(equalTo: backgroundCard.rightAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: backgroundCard.bottomAnchor, constant: -16).isActive = true
    }
    
    func setupViews() {
        
        addSubview(backgroundCard)
        setupBackgroundCard()
        
        addSubview(titleLabel)
        setupTitleLabel()
        
        addSubview(tableView)
        setupTableView()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: cellID)
        
    }
    
}
