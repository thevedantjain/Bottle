//
//  ProjectFormView.swift
//  Bottle 2
//
//  Created by Vedant Jain on 12/07/19.
//  Copyright © 2019 Vedant Jain. All rights reserved.
//

import UIKit
import Alamofire

class ProjectFormView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var instance: ProjectFormLauncher?
    var homeCollectionViewControllerInstance: HomeCollectionViewController?
    
    let backgroundCard: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 27
        view.layer.masksToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = "Create Project"
        label.textAlignment = .center
        return label
    }()
    
    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Title"
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 10
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        textField.layer.borderColor = UIColor(red: 0.80, green: 0.80, blue: 0.80, alpha: 1.0).cgColor
        textField.layer.borderWidth = 1
        textField.textAlignment = .center
        textField.isUserInteractionEnabled = true
        textField.addTarget(self, action: #selector(beginEditing), for: .touchUpInside)
        return textField
    }()
    
    @objc func beginEditing(textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    lazy var workspacePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.dataSource = self
        picker.delegate = self
        picker.showsSelectionIndicator = true
        return picker
    }()
    
    let workspaceTextField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor(red: 0.80, green: 0.80, blue: 0.80, alpha: 1.0).cgColor
        textField.layer.borderWidth = 1
        textField.textAlignment = .center
        return textField
    }()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return homeCollectionViewControllerInstance?.workspaces.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return homeCollectionViewControllerInstance?.workspaces[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        workspaceTextField.text = homeCollectionViewControllerInstance?.workspaces[row].name
    }
    
    let addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 1, alpha: 1.0)
        button.setTitle("Create", for: .normal)
        button.addTarget(self, action: #selector(handleProject), for: .touchUpInside)
        button.setTitleColor(UIColor.white, for: UIControl.State())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    func setupViews() {
        
        //        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        
        //        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        addSubview(backgroundCard)
        setupBackgroundCard()
        
        addSubview(titleLabel)
        setupTitleLabel()
        
        addSubview(titleTextField)
        setupTitleTextField()
        
        addSubview(workspaceTextField)
        setupWorkspaceTextField()
        
        addSubview(addButton)
        setupAddButton()
        
    }
    
    @objc func handleProject() {
        
        // check if all inputs are valid
        // send requests
        
        guard let title = titleTextField.text else {
            handleMessage(title: "Invalid")
            return
        }
        
        if title == "" {
            handleMessage(title: "Please enter title.")
            return
        }
        
        self.endEditing(true)
        // make requests
        
        let createdBy: Int = Int(homeCollectionViewControllerInstance?.mainUser?.id ?? 6)
        let workspace: Int = Int((homeCollectionViewControllerInstance?.workspaces[workspacePicker.selectedRow(inComponent: 0)].id)!)
        
        createProject(title: title , createdBy: createdBy, workspace: workspace) {
            self.instance?.handleDismiss()
        }
        
        
    }
    
    fileprivate func createProject(title: String, createdBy: Int, workspace: Int, completion: @escaping () -> ()) {
        
        let url = "https://wg9fx8sfq8.execute-api.ap-south-1.amazonaws.com/default/projects"
        
        let parameters: Parameters = [
            "title": title,
            "createdBy": createdBy,
            "workspace": workspace,
        ]
        
        let headers = [
            "Content-type": "application/json"
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters as Parameters, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success:
                print(response)
                completion()
                break
            case .failure(let error):
                print(error)
                break
            }
        }
        
    }
    
    func clearFields() {
        titleTextField.text = ""
        workspaceTextField.text = ""
    }
    
    fileprivate func handleMessage(title: String) {
        // sets title of login button to show error for 2 seconds
        // then resets title of login button to "Login"
        animateLoginButtonText(title: title, duration: 0.25)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            self.animateLoginButtonText(title: "Submit", duration: 0.25)
        })
        return
    }
    
    fileprivate func animateLoginButtonText(title: String, duration: Double) {
        UIView.transition(with: addButton, duration: TimeInterval(duration), options: .transitionCrossDissolve, animations: {
            self.addButton.setTitle(title, for: .normal)
        }, completion: nil)
    }
    
    fileprivate func setupBackgroundCard() {
        backgroundCard.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backgroundCard.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        backgroundCard.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        backgroundCard.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    fileprivate func setupTitleLabel() {
        titleLabel.topAnchor.constraint(equalTo: backgroundCard.topAnchor, constant: 16).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: backgroundCard.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: backgroundCard.trailingAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    fileprivate func setupTitleTextField() {
        titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        titleTextField.leadingAnchor.constraint(equalTo: backgroundCard.leadingAnchor, constant: 16).isActive = true
        titleTextField.trailingAnchor.constraint(equalTo: backgroundCard.trailingAnchor, constant: -16).isActive = true
        titleTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    fileprivate func setupWorkspaceTextField() {
        workspaceTextField.inputView = workspacePicker
        workspaceTextField.placeholder = "Select workspace"
        workspaceTextField.tintColor = .clear
        workspaceTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 8).isActive = true
        workspaceTextField.leadingAnchor.constraint(equalTo: backgroundCard.leadingAnchor, constant: 16).isActive = true
        workspaceTextField.trailingAnchor.constraint(equalTo: backgroundCard.trailingAnchor, constant: -16).isActive = true
        workspaceTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    fileprivate func setupAddButton() {
        addButton.topAnchor.constraint(equalTo: workspaceTextField.bottomAnchor, constant: 16).isActive = true
        addButton.leadingAnchor.constraint(equalTo: backgroundCard.leadingAnchor, constant: 16).isActive = true
        addButton.trailingAnchor.constraint(equalTo: backgroundCard.trailingAnchor, constant: -16).isActive = true
        addButton.bottomAnchor.constraint(equalTo: backgroundCard.bottomAnchor, constant: -16).isActive = true
    }
    
    
    
}
