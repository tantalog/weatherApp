import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
    }
    
    func setupControllers() {
        let currentWeatherViewController = CurrentWeatherViewController()
        currentWeatherViewController.tabBarItem = UITabBarItem(title: "Today", image: UIImage(systemName: "sun.max"), selectedImage: nil)
        let forecastViewController = ForecastViewController()
        forecastViewController.tabBarItem = UITabBarItem(title: "Forecast", image: UIImage(systemName: "cloud.moon"), selectedImage: nil)
        self.viewControllers = [currentWeatherViewController, forecastViewController]
        self.selectedIndex = 0
        self.tabBar.barTintColor = .systemBackground
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = .systemBlue
        self.tabBar.unselectedItemTintColor = .systemGray
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 10)!], for: .normal)
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 10)!], for: .selected)
    }
}
