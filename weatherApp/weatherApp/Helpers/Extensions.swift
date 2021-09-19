import Foundation
import UIKit

extension UIViewController {
    
    func setVerticalStackView(views: [UIView], spacing: CGFloat = 15) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = spacing
        
        return stackView
    }
    
    func setHorizontalStackView(views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 30
        return stackView
    }
}

extension UIColor {
    struct ProjectColors {
        static var background: UIColor  { return UIColor(named: "backGround")! }
        static var dataText: UIColor  { return UIColor(named: "dataText")! }
        static var descriptionText: UIColor  { return UIColor(named: "descriptionText")! }
        static var iconsTint: UIColor  { return UIColor(named: "iconsTint")! }
        static var tabBarBackground: UIColor  { return UIColor(named: "tabBarBackground")! }
        static var titleText: UIColor  { return UIColor(named: "titleText")! }
    }
}

extension UINavigationController {
    func makeBarButtonItem(image: UIImage = UIImage(named: "modeButtonImage")!, target: Any?, action: Selector?) -> UIBarButtonItem {
        let barButtonItem = UIBarButtonItem(image: image, style: .plain, target : target, action: action)
        return barButtonItem
    }
    
}

