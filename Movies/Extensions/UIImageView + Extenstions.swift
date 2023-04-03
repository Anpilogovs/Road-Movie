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
            }
        }
    }
}

extension UIImageView {
    func addShadow() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(1).cgColor]
        gradientLayer.locations = [0, 1, 2]
        
        let shadowLayer = CALayer()
        shadowLayer.frame = bounds
        shadowLayer.addSublayer(gradientLayer)
        layer.addSublayer(shadowLayer)
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
