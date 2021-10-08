//
//  UIView+Extension.swift
//  TheOAA
//
//  Created by Nguyễn Việt Anh on 15/09/2021.
//

import UIKit

extension UIView {
    func fitSuperviewConstraint() {
        self.translatesAutoresizingMaskIntoConstraints = false
        let superview = self.superview!
        
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: 0).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 0).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: 0).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: 0).isActive = true
        
    }
    
}
