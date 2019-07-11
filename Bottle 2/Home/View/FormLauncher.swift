//
//  FormLauncher.swift
//  Bottle 2
//
//  Created by Vedant Jain on 11/07/19.
//  Copyright © 2019 Vedant Jain. All rights reserved.
//

import UIKit

class FormLauncher: NSObject {
    
    var users: [User] = []
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let blackView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let formView: FormView = {
        let view = FormView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundCard.backgroundColor = .white
        return view
    }()
    
    var topAnchorConstraint: NSLayoutConstraint?
    
    fileprivate func setupFormView(_ window: UIWindow) {
        formView.leadingAnchor.constraint(equalTo: window.leadingAnchor, constant: 8).isActive = true
        formView.trailingAnchor.constraint(equalTo: window.trailingAnchor, constant: -8).isActive = true
        formView.heightAnchor.constraint(equalToConstant: 302).isActive = true
        topAnchorConstraint = formView.topAnchor.constraint(equalTo: window.bottomAnchor)
        formView.layoutIfNeeded()
        formView.instance = self
        formView.beginEditing(textField: formView.titleTextField)
        formView.alpha = 0
    }
    
    func setupViews() {
        
        if let window = UIApplication.shared.keyWindow {
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            window.addSubview(formView)
            blackView.frame = window.frame
            blackView.alpha = 0

            setupFormView(window)
            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                self.blackView.alpha = 0.5
                self.formView.alpha = 1
            }, completion: nil)
            
        }
        
    }
    
    func handleKeyboard(height: Int) {
        formView.layoutIfNeeded()
        UIView.animate(withDuration: 1) {
            self.topAnchorConstraint?.constant = CGFloat((-318 - height))
            self.topAnchorConstraint?.isActive = true
            self.formView.layoutIfNeeded()
        }
    }
    
    @objc func handleDismiss() {
        UIView.animate(withDuration:1) {
            self.topAnchorConstraint?.constant = 0
            self.formView.layoutIfNeeded()
            self.formView.endEditing(true)
            self.formView.clearFields()
            self.formView.alpha = 0
            self.blackView.alpha = 0
        }
    }
    
}
