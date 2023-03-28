//
//  UIView + Extensions.swift
//  Movies
//
//  Created by Сергей Анпилогов on 29.03.2023.
//

import UIKit


extension UIView {
    func addRoundedCornersAndBorder(cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor) {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        clipsToBounds = true
    }
}

