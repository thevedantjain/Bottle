//
//  RegisterViewController.swift
//  Bottle 2
//
//  Created by Vedant Jain on 28/06/19.
//  Copyright © 2019 Vedant Jain. All rights reserved.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        view.backgroundColor = .white
        
        view.addSubview(nameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(passwordConfirmTextField)
        view.addSubview(organisationTextField)
        view.addSubview(registerButton)
        view.addSubview(cancelButton)
        
        nameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 128).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        passwordConfirmTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16).isActive = true
        passwordConfirmTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        passwordConfirmTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        passwordConfirmTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        organisationTextField.topAnchor.constraint(equalTo: passwordConfirmTextField.bottomAnchor, constant: 16).isActive = true
        organisationTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        organisationTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        organisationTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        registerButton.topAnchor.constraint(equalTo: organisationTextField.bottomAnchor, constant: 16).isActive = true
        registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        cancelButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 16).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // Do any additional setup after loading the view.
    }
    
//    func userRegister(name: String, email:String, password: String, passwordConfirm: String, organisation: String) {
//        let parameters = ["name": name, "password" : password, "password_confirmation" : passwordConfirm, "email" : email, "organisation": organisation]
//
//
//        Alamofire.request("https://boardtest.iecsemanipal.com/register", method: .post, parameters: parameters, headers: header).responseJSON{ response in
//            switch response.result {
//            case .success:
//                guard let items = response.result.value as? [String:AnyObject] else {
//                    //                    DispatchQueue.main.async(execute: {
//                    //                        self.loginButton.hideLoading()
//                    //                        let alertController = UIAlertController(title: "Unable to Fetch Data", message: "Please try again later.", preferredStyle: .alert)
//                    //                        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//                    //                        alertController.addAction(defaultAction)
//                    //                        self.present(alertController, animated: true, completion: nil)
//                    //                    })
//                    return
//                }
//                if let success = items["success"] as? Int {
//                    if success == 1 {
//                        print("successfully registered")
//                        self.dismiss(animated: true, completion: nil)
//                    }
//                    else {
//                        print("registration failed")
//                    }
//                }
//                print(items)
//
//                break
//            case .failure(let error):
//                //                self.loginButton.hideLoading()
//                //                self.handleIncompleteDetails(text: "Uh, Oh! The server is not responding.")
//                //                AudioServicesPlaySystemSound(1521)
//                print(error)
//            }
//        }
//    }
    
    let nameTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Name"
        text.textAlignment = .center
        text.translatesAutoresizingMaskIntoConstraints = false
        text.layer.borderColor = UIColor(red: 0.80, green: 0.80, blue: 0.80, alpha: 1.0).cgColor
        text.layer.cornerRadius = 10
        text.layer.masksToBounds = true
        text.layer.borderWidth = 1
        return text
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        tf.autocapitalizationType = UITextAutocapitalizationType.none
        tf.textAlignment = .center
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.keyboardType = .emailAddress
        tf.layer.borderColor = UIColor(red: 0.80, green: 0.80, blue: 0.80, alpha: 1.0).cgColor
        tf.layer.cornerRadius = 10
        tf.layer.masksToBounds = true
        tf.layer.borderWidth = 1
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.textAlignment = .center
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        tf.layer.borderColor = UIColor(red: 0.80, green: 0.80, blue: 0.80, alpha: 1.0).cgColor
        tf.layer.cornerRadius = 10
        tf.layer.masksToBounds = true
        tf.layer.borderWidth = 1
        return tf
    }()
    
    let passwordConfirmTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.textAlignment = .center
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        tf.layer.borderColor = UIColor(red: 0.80, green: 0.80, blue: 0.80, alpha: 1.0).cgColor
        tf.layer.cornerRadius = 10
        tf.layer.masksToBounds = true
        tf.layer.borderWidth = 1
        return tf
    }()
    
    let organisationTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Organisation"
        text.translatesAutoresizingMaskIntoConstraints = false
        text.layer.borderColor = UIColor(red: 0.80, green: 0.80, blue: 0.80, alpha: 1.0).cgColor
        text.layer.cornerRadius = 10
        text.textAlignment = .center
        text.layer.masksToBounds = true
        text.layer.borderWidth = 1
        return text
    }()
    
    let registerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 1, alpha: 1.0)
        button.setTitle("Register", for: .normal)
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        button.setTitleColor(UIColor.white, for: UIControl.State())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.80, green: 0.80, blue: 0.80, alpha: 1.0)
        button.setTitle("Cancel", for: .normal)
        button.addTarget(self, action: #selector(cancelRegister), for: .touchUpInside)
        button.setTitleColor(UIColor.white, for: UIControl.State())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    @objc func cancelRegister() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleRegister() {
        guard let email = emailTextField.text, let password = passwordTextField.text, let passwordConfirm = passwordConfirmTextField.text, let organisation = organisationTextField.text, let name = nameTextField.text else {
            handleIncompleteDetails(text: "Invalid Format")
            return
        }
        if email == "" && password == ""{
            handleIncompleteDetails(text: "Please enter your Credentials")
            return
        }
        if email == ""{
            handleIncompleteDetails(text: "Please enter your Email ID")
            return
        }
        if name == "" {
            handleIncompleteDetails(text: "Please enter name")
            return
        }
        
        if organisation == "" {
            handleIncompleteDetails(text: "Please enter organisation")
            return
        }
        
        if validateEmail(enteredEmail: email) == false {
            handleIncompleteDetails(text: "Invalid Email ID")
            return
        }
        if password == ""{
            handleIncompleteDetails(text: "Please enter your Password")
            return
        }
        if password != passwordConfirm {
            handleIncompleteDetails(text: "Passwords do not match")
            return
        }
        
        view.endEditing(true)
        
//        userRegister(name: name, email: email, password: password, passwordConfirm: passwordConfirm, organisation: organisation)
    }
    
    func validateEmail(enteredEmail: String) -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
        
    }
    
    func handleIncompleteDetails(text: String){
        registerButton.setTitle(text, for: UIControl.State())
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            self.registerButton.setTitle("Register", for: UIControl.State())
            
        })
        return
        
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
}
