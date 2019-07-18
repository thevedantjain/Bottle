//
//  TaskDetailsViewController.swift
//  Bottle 2
//
//  Created by Vedant Jain on 23/05/19.
//  Copyright © 2019 Vedant Jain. All rights reserved.
//

import UIKit

class TaskDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(doneButton)
        setupDoneButton()

        view.addSubview(taskTitleLabel)
        setupTitleLabel()
        
        view.addSubview(taskDeadlineLabel)
        setupDeadlineLabel()
        
        view.addSubview(taskDescriptionLabel)
        setupTaskDescriptionLabel()
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
    
    let doneButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("Done", for: .normal)
        button.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate func setupDoneButton() {
        doneButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 77).isActive = true
        doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        doneButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    fileprivate func setupTitleLabel() {
        taskTitleLabel.topAnchor.constraint(equalTo: doneButton.bottomAnchor, constant: 16).isActive = true
        taskTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        taskTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        taskTitleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    fileprivate func setupDeadlineLabel() {
        taskDeadlineLabel.topAnchor.constraint(equalTo: taskTitleLabel.bottomAnchor, constant: 16).isActive = true
        taskDeadlineLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        taskDeadlineLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        taskDeadlineLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    fileprivate func setupTaskDescriptionLabel() {
        taskDescriptionLabel.topAnchor.constraint(equalTo: taskDescriptionLabel.bottomAnchor, constant: 16).isActive = true
        taskDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        taskDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16).isActive = true
        taskDescriptionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16).isActive = true
    }
    
    @objc func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }

}
