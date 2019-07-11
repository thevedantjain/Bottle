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
    
    var hideFormConstraint: NSLayoutConstraint?
    var showFormConstraint: NSLayoutConstraint?
    
    fileprivate func setupFormView(_ window: UIWindow) {
        formView.leadingAnchor.constraint(equalTo: window.leadingAnchor, constant: 8).isActive = true
        formView.trailingAnchor.constraint(equalTo: window.trailingAnchor, constant: -8).isActive = true
        formView.heightAnchor.constraint(equalToConstant: 302).isActive = true
        hideFormConstraint = formView.topAnchor.constraint(equalTo: window.bottomAnchor)
        hideFormConstraint?.isActive = true
        showFormConstraint = formView.bottomAnchor.constraint(equalTo: window.safeAreaLayoutGuide.bottomAnchor, constant: -310)
        formView.instance = self
        formView.beginEditing(textField: formView.titleTextField)
        formView.alpha = 1
    }
    
    func setupViews(completion: @escaping ()->()) {
        
        if let window = UIApplication.shared.keyWindow {
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            window.addSubview(formView)
            blackView.frame = window.frame
            blackView.alpha = 1

            setupFormView(window)
            
            completion()
        }
        
    }
    
    func animate() {
        if let window = UIApplication.shared.keyWindow {
            self.hideFormConstraint?.isActive = false
            self.showFormConstraint?.isActive = true
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                window.layoutIfNeeded()
                self.blackView.alpha = 0.5
                self.formView.alpha = 1
            }, completion: nil)
        }
        
    }
    
    func handleKeyboard(height: Int) {
        if let window = UIApplication.shared.keyWindow {
            formView.layoutIfNeeded()
            hideFormConstraint?.isActive = false
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.showFormConstraint?.isActive = true
                window.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    @objc func handleDismiss() {
        if let window = UIApplication.shared.keyWindow {
            self.showFormConstraint?.isActive = false
            self.formView.endEditing(true)
            self.formView.clearFields()
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.hideFormConstraint?.isActive = true
                window.layoutIfNeeded()
                self.formView.alpha = 1
                self.blackView.alpha = 0
            }, completion: nil)
        }
    }
    
}
