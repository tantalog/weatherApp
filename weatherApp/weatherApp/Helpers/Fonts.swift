import Foundation
import UIKit

struct AppFont {
    enum FontType: String {
        case poppinsRegular = "Poppins-Regular"
    }
    static func font(type: FontType, size: CGFloat) -> UIFont{
        return UIFont(name: type.rawValue, size: size)!
    }
}
