//
//  FormView.swift
//  Bottle 2
//
//  Created by Vedant Jain on 11/07/19.
//  Copyright © 2019 Vedant Jain. All rights reserved.
//

import UIKit
import Alamofire

class FormView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var instance: FormLauncher?
    
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
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.text = "Add Task"
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
    
    let detailsTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Details"
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 10
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        textField.layer.borderColor = UIColor(red: 0.80, green: 0.80, blue: 0.80, alpha: 1.0).cgColor
        textField.layer.borderWidth = 1
        textField.textAlignment = .center
        return textField
    }()
    
    lazy var assignedPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.dataSource = self
        picker.delegate = self
        return picker
    }()
    
    let assignedToTextField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Details"
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
        return instance?.users.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return instance?.users[row].username
    }
    
    let addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 1, alpha: 1.0)
        button.setTitle("Submit", for: .normal)
        button.addTarget(self, action: #selector(handleTask), for: .touchUpInside)
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
        
        addSubview(detailsTextField)
        setupDetailsTextField()
        
        addSubview(assignedToTextField)
        setupAssignedTextField()
        
        addSubview(addButton)
        setupAddButton()
        
    }
    
    @objc func handleTask() {
        
        // check if all inputs are valid
        // send requests
        var user: User?

        guard let title = titleTextField.text, let details = detailsTextField.text else {
            handleMessage(title: "Invalid")
            return
        }
        
        if title == "" {
            handleMessage(title: "Please enter title.")
            return
        }
        
        if details == "" {
            handleMessage(title: "Please enter details.")
            return
        }
        
        if assignedPicker.selectedRow(inComponent: 0) == 0 {
            handleMessage(title: "Please select user.")
            return
        }
        
        self.endEditing(true)
        // make requests
        
    }
    
//    @objc func keyboardDidShow(notification: NSNotification) {
//        if let height = ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) {
//            instance?.handleKeyboard(height: Int(height.size.height) + 64)
//        }
//    }
//    
//    @objc func keyboardDidHide(notification: NSNotification) {
//        instance?.handleKeyboard(height: 0)
//    }
    
    func clearFields() {
        titleTextField.text = ""
        detailsTextField.text = ""
        assignedToTextField.text = ""
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
        titleLabel.heightAnchor.constraint(equalToConstant: 23).isActive = true
    }
    
    fileprivate func setupTitleTextField() {
        titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        titleTextField.leadingAnchor.constraint(equalTo: backgroundCard.leadingAnchor, constant: 16).isActive = true
        titleTextField.trailingAnchor.constraint(equalTo: backgroundCard.trailingAnchor, constant: -16).isActive = true
        titleTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    fileprivate func setupDetailsTextField() {
        detailsTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 8).isActive = true
        detailsTextField.leadingAnchor.constraint(equalTo: backgroundCard.leadingAnchor, constant: 16).isActive = true
        detailsTextField.trailingAnchor.constraint(equalTo: backgroundCard.trailingAnchor, constant: -16).isActive = true
        detailsTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    fileprivate func setupAssignedTextField() {
        assignedToTextField.inputView = assignedPicker
        assignedToTextField.placeholder = instance?.users[0].username ?? "Pick a user"
        assignedToTextField.topAnchor.constraint(equalTo: detailsTextField.bottomAnchor, constant: 8).isActive = true
        assignedToTextField.leadingAnchor.constraint(equalTo: backgroundCard.leadingAnchor, constant: 16).isActive = true
        assignedToTextField.trailingAnchor.constraint(equalTo: backgroundCard.trailingAnchor, constant: -16).isActive = true
        assignedToTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    fileprivate func setupAddButton() {
        addButton.topAnchor.constraint(equalTo: assignedToTextField.bottomAnchor, constant: 16).isActive = true
        addButton.leadingAnchor.constraint(equalTo: backgroundCard.leadingAnchor, constant: 16).isActive = true
        addButton.trailingAnchor.constraint(equalTo: backgroundCard.trailingAnchor, constant: -16).isActive = true
        addButton.bottomAnchor.constraint(equalTo: backgroundCard.bottomAnchor, constant: -16).isActive = true
    }
    
    
    
}
