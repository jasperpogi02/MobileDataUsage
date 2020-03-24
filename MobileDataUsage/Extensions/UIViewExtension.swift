//
//  UIViewExtension.swift
//  MobileDataUsage
//
//  Created by cdgtaxiMac on 3/24/20.
//

import Foundation
import UIKit

extension UIView {
    func dropShadow(color: UIColor) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 3
        self.layer.shouldRasterize = false
    }
}
