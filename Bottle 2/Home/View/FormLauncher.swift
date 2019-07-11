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
    
    func setupViews() {
        
        if let window = UIApplication.shared.keyWindow {
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            blackView.frame = window.frame
            blackView.alpha = 0
            
            window.addSubview(formView)
            formView.instance = self
//            formView.alpha = 0
            let y = window.frame.height - 400
            formView.frame = CGRect(x: 0, y: 100, width: window.frame.width, height: 500)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 0.5
                self.formView.frame.origin.y = 200
//                self.formView.alpha = 1
            }, completion: nil)
            
        }
        
    }
    
    @objc func handleDismiss() {
        
        if let window = UIApplication.shared.keyWindow {
            UIView.animate(withDuration: 0.5) {
                self.blackView.alpha = 0
                self.formView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: 500)
//                self.formView.alpha = 0
            }
        }
    }
    
}
