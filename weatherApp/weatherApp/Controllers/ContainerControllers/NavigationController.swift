import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }

    
    private func configureNavigationBar() {
        let titleDict: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: AppFont.font(type: .poppinsRegular, size: 17),
                                                         NSAttributedString.Key.foregroundColor: UIColor.ProjectColors.titleText]
        self.navigationBar.titleTextAttributes = titleDict
        self.navigationBar.backgroundColor = UIColor.ProjectColors.background
        self.navigationBar.barTintColor = UIColor.ProjectColors.background
        self.navigationBar.tintColor = UIColor.ProjectColors.titleText
        self.navigationBar.isTranslucent = false
    }


}
