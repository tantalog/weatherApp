import Foundation
import UIKit

extension UIResponder {
    
    func setVerticalStackView(views: [UIView], spacing: CGFloat = 5, alignment: UIStackView.Alignment = .center ) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = spacing
        stackView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return stackView
    }
    
    func setHorizontalStackView(views: [UIView], spacing: CGFloat = 100, distribution: UIStackView.Distribution = .fillEqually) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .horizontal
        stackView.distribution = distribution
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
    func makeBarButtonItem(image: UIImage = UIImage(named: "modeButtonImage")!, target: Any?, action: Selector?) -> UIBarButtonItem {
        let button: UIButton = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(image, for: .normal)
        button.addTarget(target, action: action!, for: .touchUpInside)
        let barButtonItem = UIBarButtonItem(customView: button)
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

struct AnchoredConstraints {
    var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}

extension UIView {
    
    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) -> AnchoredConstraints {
        
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        
        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        
        if let leading = leading {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        
        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        
        if let trailing = trailing {
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }
        
        if size.width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
        }
        
        if size.height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }
        
        [anchoredConstraints.top, anchoredConstraints.leading, anchoredConstraints.bottom, anchoredConstraints.trailing, anchoredConstraints.width, anchoredConstraints.height].forEach{ $0?.isActive = true }
        
        return anchoredConstraints
    }
    
    func centerX(in view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func centerY(in view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

extension UIImage {
    class func weatherIcon(of name: String) -> UIImage? {
        switch name {
        case "01d":
            return UIImage(named: "01d")
        case "01n":
            return UIImage(named: "01n")
        case "02d":
            return UIImage(named: "02d")
        case "02n":
            return UIImage(named: "02n")
        case "03d":
            return UIImage(named: "03d")
        case "03n":
            return UIImage(named: "03n")
        case "04d":
            return UIImage(named: "04d")
        case "04n":
            return UIImage(named: "04n")
        case "09d":
            return UIImage(named: "09d")
        case "09n":
            return UIImage(named: "09n")
        case "10d":
            return UIImage(named: "10d")
        case "10n":
            return UIImage(named: "10n")
        case "11d":
            return UIImage(named: "11d")
        case "11n":
            return UIImage(named: "11n")
        case "13d":
            return UIImage(named: "13d")
        case "13n":
            return UIImage(named: "13n")
        case "50d":
            return UIImage(named: "50d")
        case "50n":
            return UIImage(named: "50n")
        default:
            return UIImage(named: "clear-day")
        }
    }
}

