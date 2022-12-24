//
//  File.swift
//  Movies
//
//  Created by Сергей Анпилогов on 18.12.2022.
//

import Foundation
import UIKit

class Utilities {
    
    static func styleTextField(_ textfield: UITextField) {
        
        //Create the botton line
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0,
                                  y: textfield.frame.height - 2,
                                  width: textfield.frame.width,
                                  height: 2)
        
        textfield.borderStyle = .none
        textfield.layer.addSublayer(bottomLine)
    }
    
    static func styleFilledButton(_ bottom: UIButton) {
        
        bottom.backgroundColor = UIColor.init(red: 48/255,
                                              green: 173/255,
                                              blue: 99/255, alpha: 1)
        bottom.layer.cornerRadius = 25.0
        bottom.tintColor = UIColor.white
    }
    
    static func styleHollowButton(_ bottom: UIButton) {
        
        //Hollow rounded corner style
        bottom.layer.borderWidth = 2
        bottom.layer.cornerRadius = 25.0
        bottom.layer.borderColor = UIColor.black.cgColor
        bottom.tintColor = UIColor.black
        
    }
    
    static func isPasswordValid(_ password: String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@",
                                       "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
}
