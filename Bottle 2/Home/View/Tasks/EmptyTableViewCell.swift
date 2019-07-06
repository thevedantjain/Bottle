//
//  EmptyTableViewCell.swift
//  Bottle 2
//
//  Created by Vedant Jain on 06/07/19.
//  Copyright © 2019 Vedant Jain. All rights reserved.
//

import UIKit

class EmptyTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    let iv: UIImageView = {
        let image = UIImage(named: "notasks")?.alpha(0.6)
        let view = UIImageView(image: image)
        view.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "No tasks!"
        label.textColor = UIColor(white: 0, alpha: 0.6)
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        addSubview(iv)
        iv.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        iv.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: iv.bottomAnchor, constant: 8).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
    }

}

extension UIImage {
    
    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
