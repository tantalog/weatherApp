
import UIKit

class ProjectStyleLabel: UILabel {
    
    convenience init(frame:CGRect = .zero, text:String = "", fontSize: CGFloat = 17, textColor: UIColor = UIColor.ProjectColors.dataText) {

        self.init(frame:frame)
        self.text = text
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: fontSize)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
