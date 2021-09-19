
import UIKit

class ProjectStyleLabel: UILabel {
    
    convenience init(frame:CGRect = .zero, text:String = "", fontSize: CGFloat = 14, fontColor: UIColor = .black) {

        self.init(frame:frame)
        self.text = text
        self.textColor = fontColor
        self.font = UIFont.systemFont(ofSize: fontSize)
        self.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
}
