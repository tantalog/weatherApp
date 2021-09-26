import UIKit

class TabBarController: UITabBarController {
    let currentWeatherViewController = CurrentWeatherViewController()
    let forecastViewController = ForecastViewController()
    private var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.configLocation()
        viewModel.startLoading()
        configireUI()
        setupControllers()
    }
    
    func setupControllers() {
        let currentWeatherController = NavigationController.init(rootViewController: currentWeatherViewController)
        currentWeatherController.tabBarItem = UITabBarItem(title: "Today", image: UIImage(systemName: "sun.max"), selectedImage: nil)
        let forecastController = NavigationController.init(rootViewController: forecastViewController)
        forecastController.tabBarItem = UITabBarItem(title: "Forecast", image: UIImage(systemName: "cloud.moon"), selectedImage: nil)
        self.viewControllers = [currentWeatherController, forecastController]
        self.selectedIndex = 0
        self.tabBar.barTintColor = UIColor.ProjectColors.tabBarBackground
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = .systemBlue
        self.tabBar.unselectedItemTintColor = .systemGray
    }
    
    func configireUI() {
        self.viewModel.icon.bind { (image) in self.currentWeatherViewController.conditionIcon.image = image }
//        self.viewModel.city.bind { (text) in self.currentWeatherViewController.cityLabel.text = text }
        self.viewModel.temp.bind { (text) in self.currentWeatherViewController.tempLabel.text = text }
        self.viewModel.weatherDescription.bind { (text) in self.currentWeatherViewController.descriptionLabel.text = text }
        self.viewModel.humidity.bind { (text) in self.currentWeatherViewController.humidityLabel.text = text }
        self.viewModel.probabilityOfPrecipitation.bind { (text) in self.currentWeatherViewController.probabilityOfPrecipitationLabel.text = text }
        self.viewModel.pressure.bind { (text) in self.currentWeatherViewController.pressureLabel.text = text }
        self.viewModel.windSpeed.bind { (text) in self.currentWeatherViewController.windSpeedLabel.text = text }
        self.viewModel.windDirection.bind { (text) in self.currentWeatherViewController.windDirectionLabel.text = text }
        self.viewModel.days.bind { (array) in
            self.forecastViewController.days = array
        }
        self.viewModel.days.bind { (array) in
            self.forecastViewController.days = array
        }
        self.viewModel.icons.bind { (array) in
            self.forecastViewController.icons = array
        }
        self.viewModel.timestampsArray.bind { (array) in
            self.forecastViewController.timestamps = array
        }
        self.viewModel.descriptionsArray.bind { (array) in
            self.forecastViewController.descriptions = array
        }
        self.viewModel.tempsArray.bind { (array) in
            self.forecastViewController.temps = array
        }
        self.viewModel.city.bind { (city) in
            self.forecastViewController.navigationItem.title = city
        }
    }
    
    
}
