//
//  UIImageView + Extenstions.swift
//  Movies
//
//  Created by Сергей Анпилогов on 02.04.2023.
//

import UIKit


extension UIImageView {
    func setImage(with url: String, alpha: CGFloat? = nil) {
        guard let url = URL(string: url) else { return }
        self.sd_setImage(with: url) { [weak self] _,_,_,_   in
            if let strongSelf = self, let image = self?.image {
                strongSelf.image = image
                let overlayView = UIView(frame: strongSelf.bounds)
                overlayView.backgroundColor = UIColor.black.withAlphaComponent(alpha ?? 0)
                overlayView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                strongSelf.addSubview(overlayView)
//                strongSelf.bringSubviewToFront(strongSelf.subviews[0])
            }
        }
    }
}





//extension UIImageView {
//    func setImage(with url: String, blurRadius: CGFloat? = nil) {
//        guard let url = URL(string: url) else { return }
//        self.sd_setImage(with: url) { [weak self] _,_,_,_  in
//            if let strongSelf = self, let image = self?.image {
//                strongSelf.image = image
//                if let blurRadius = blurRadius, blurRadius > 0 {
//                    let overlayView = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterialLight))
//                    overlayView.frame = strongSelf.bounds
//                    overlayView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//                    strongSelf.addSubview(overlayView)
//                }
//            }
//        }
//    }
//}
