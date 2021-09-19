import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
    }
    
    func setupControllers() {
        let currentWeatherController = NavigationController.init(rootViewController: CurrentWeatherViewController())
        currentWeatherController.tabBarItem = UITabBarItem(title: "Today", image: UIImage(systemName: "sun.max"), selectedImage: nil)
        let forecastController = NavigationController.init(rootViewController: ForecastViewController())
        forecastController.tabBarItem = UITabBarItem(title: "Forecast", image: UIImage(systemName: "cloud.moon"), selectedImage: nil)
        self.viewControllers = [currentWeatherController, forecastController]
        self.selectedIndex = 0
        self.tabBar.barTintColor = UIColor.ProjectColors.tabBarBackground
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = .systemBlue
        self.tabBar.unselectedItemTintColor = .systemGray
    }
}
