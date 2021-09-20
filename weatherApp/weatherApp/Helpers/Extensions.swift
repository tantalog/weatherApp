import Foundation
import UIKit

extension UIViewController {
    
    func setVerticalStackView(views: [UIView], spacing: CGFloat = 5, alignment: UIStackView.Alignment = .center ) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = spacing
        stackView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return stackView
    }
    
    func setHorizontalStackView(views: [UIView], spacing: CGFloat = 150) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = spacing
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
    var image: UIImage?  {UIImage(named: "modeButtonImage")}
    func makeBarButtonItem(image: UIImage = UIImage(named: "modeButtonImage")!, target: Any?, action: Selector?) -> UIBarButtonItem {
        let barButtonItem = UIBarButtonItem(image: image, style: .plain, target : target, action: action)
        return barButtonItem
    }
    
}

extension UIViewController {
    static func makeIconImageView(systemName: String) -> UIImageView {
        let config = UIImage.SymbolConfiguration(font: AppFont.font(type: .poppinsRegular, size: 25))
        let iconImage = UIImage(systemName: systemName, withConfiguration: config)
        iconImage?.withTintColor(.systemBlue)
        let iconView = UIImageView(image: iconImage)
        return iconView
    }
    
}

