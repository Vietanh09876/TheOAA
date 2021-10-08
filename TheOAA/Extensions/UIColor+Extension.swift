//
//  UIColor+Extension.swift
//  TheOAA
//
//  Created by Nguyễn Việt Anh on 14/09/2021.
//


import UIKit

extension UIColor {
    func ContainerViewColor() -> UIColor {
        return UIColor(red: 0.82, green: 0.89, blue: 0.79, alpha: 1.00)
    }
    
    func BorderColor() -> UIColor {
        return UIColor(red: 0.01, green: 0.46, blue: 0.25, alpha: 1.00)
    }
    
    func CellSelectedBackgroundColor() -> UIColor {
        return UIColor(red: 0.12, green: 0.55, blue: 0.27, alpha: 1.00)
    }
    
    func TableViewSeparatorColor() -> UIColor {
        return UIColor(red: 0.47, green: 0.72, blue: 0.38, alpha: 1.00)
    }
    
    func MainTextColor(alpha: CGFloat) -> UIColor {
        return UIColor(red: 0.23, green: 0.35, blue: 0.28, alpha: alpha)
    }
    
    func SubTextColor(alpha: CGFloat) -> UIColor {
        return UIColor(red: 0.05, green: 0.24, blue: 0.04, alpha: alpha)
    }
    
    func SpecialTextColor() -> UIColor {
        return UIColor(red: 0.35, green: 0.00, blue: 0.24, alpha: 1.00)
    }
    
    func WarningTextColor() -> UIColor {
        return UIColor(red: 0.64, green: 0.20, blue: 0.20, alpha: 1.00)
    }
 }
