//
//  LoginViewController.swift
//  Bottle 2
//
//  Created by Vedant Jain on 28/06/19.
//  Copyright © 2019 Vedant Jain. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        tf.autocapitalizationType = UITextAutocapitalizationType.none
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = .center
        tf.layer.borderColor = UIColor(red: 0.80, green: 0.80, blue: 0.80, alpha: 1.0).cgColor
        tf.layer.cornerRadius = 10
        tf.layer.masksToBounds = true
        tf.layer.borderWidth = 1
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.layer.borderColor = UIColor(red: 0.80, green: 0.80, blue: 0.80, alpha: 1.0).cgColor
        tf.layer.cornerRadius = 10
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = .center
        tf.layer.masksToBounds = true
        tf.layer.borderWidth = 1
        return tf
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 1, alpha: 1.0)
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.setTitleColor(UIColor.white, for: UIControl.State())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    let registerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.80, green: 0.80, blue: 0.80, alpha: 1.0)
        button.setTitle("Sign Up", for: .normal)
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        button.setTitleColor(UIColor.white, for: UIControl.State())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    @objc func handleLogin() {
        // check credentials
        guard let username = usernameTextField.text, let password = passwordTextField.text else {
            handleMessage(title: "Invalid")
            return
        }
        
        if username == "" && password == "" {
            handleMessage(title: "Please enter credentials.")
            return
        }
        
        if username == "" {
            handleMessage(title: "Please enter username.")
            return
        }
        
        if password == "" {
            handleMessage(title: "Please enter password.")
            return
        }
        
        if (!validateUsername(username: username)) {
            // invalid username
            handleMessage(title: "Invalid username.")
            return
        }
        
        view.endEditing(true)
        userLogin(username: username, password: password)
        
    }
    
    @objc func handleRegister() {
        //present registerViewController
        self.present(RegisterViewController(), animated: true, completion: nil)
    }
    
    fileprivate func handleMessage(title: String) {
        // sets title of login button to show error for 2 seconds
        // then resets title of login button to "Login"
        animateLoginButtonText(title: title, duration: 0.25)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            self.animateLoginButtonText(title: "Login", duration: 0.25)
        })
        return
    }
    
    fileprivate func validateUsername(username: String) -> Bool {
        // return true if valid username, false if invalid
        let characterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_.")
        // characterSet.inverted means all characters except charactersIn
        if username.rangeOfCharacter(from: characterSet.inverted) != nil {
            return false
        }
        return true
    }
    
    fileprivate func animateLoginButtonText(title: String, duration: Double) {
        UIView.transition(with: loginButton, duration: TimeInterval(duration), options: .transitionCrossDissolve, animations: {
            self.loginButton.setTitle(title, for: .normal)
        }, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        setupConstraints()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    fileprivate func setupConstraints() {
        usernameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 256).isActive = true
        usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        usernameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 32).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 32).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 32).isActive = true
        registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    let header = [
        "Content-Type": "application/json"
    ]
    
    private func userLogin(username: String, password: String) {
        
        let url = "https://qkvee3o84e.execute-api.ap-south-1.amazonaws.com/default/getusers"
        
        // currently checking user through loop
        
        Alamofire.request(url, method: .get, parameters: [:], headers: header).responseJSON{ response in
            switch response.result {
            case .success:
                guard let items = response.result.value as? [[String:AnyObject]] else {
                    return
                }
                for element in items {
                    if (element["username"] as! String) == username {
                        UserDefaults.standard.set(true, forKey: "userLogin")
                        UserDefaults.standard.set(username, forKey: "username")
                        self.dismiss(animated: true, completion: nil)
                    }
                }
                // user does not exist
                self.handleMessage(title: "Please register")
                break
            case .failure(let error):
                self.handleMessage(title: "User already exists.")
                print(error)
            }
        }
        
    }
    
}
