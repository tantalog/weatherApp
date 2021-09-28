import UIKit
import CoreLocation

class TabBarController: UITabBarController {
    let currentWeatherViewController = CurrentWeatherViewController()
    let forecastViewController = ForecastViewController()

    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.distanceFilter = 1000
        manager.desiredAccuracy = 1000
        return manager
    }()
    
    private var currentLocation: CLLocation? {
        didSet {
            fetchCity()
            fetchForecast()
        }
    }
    
    private func fetchForecast() {
        guard let currentLocation = currentLocation else { return }
        
        let lat = currentLocation.coordinate.latitude
        let lon = currentLocation.coordinate.longitude
        

        ForecastManager.shared.forecastAt(latitude: lat, longitude: lon, completion: {
            response, error in
            if let error = error {
                dump(error)
            } else if let response = response {
                self.currentWeatherViewController.viewModel?.forecast = response
                self.forecastViewController.viewModel = ForecastViewModel(list: response.list)
            }
        })
    }
    
    private func fetchCity() {
        guard let currentLocation = currentLocation else { return }
        
        CLGeocoder().reverseGeocodeLocation(currentLocation, completionHandler: {
            placemarks, error in
            if let error = error {
                dump(error)
            }
            else if let city = placemarks?.first?.locality {
                let l = Location(
                    name: city,
                    latitude: currentLocation.coordinate.latitude,
                    longitude: currentLocation.coordinate.longitude)
                self.currentWeatherViewController.viewModel?.location = l
                self.forecastViewController.navigationItem.title = city
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMode()
        setupControllers()
        setupActiveNotification()
        currentWeatherViewController.viewModel = CurrentWeatherViewModel()
    }
    
    func loadMode() {
        let defaults = UserDefaults.standard
        let darkModeEnabled = defaults.bool(forKey: "darkModeEnabled")
        if darkModeEnabled {
            overrideUserInterfaceStyle = .dark
            self.navigationController?.overrideUserInterfaceStyle = .dark
            self.tabBarController?.overrideUserInterfaceStyle = .dark

        } else {
            overrideUserInterfaceStyle = .light
            self.navigationController?.overrideUserInterfaceStyle = .light
            self.tabBarController?.overrideUserInterfaceStyle = .light
        }
    }
    
    private func setupActiveNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(TabBarController.applicationDidBecomeActive(notification:)),
            name: UIApplication.didBecomeActiveNotification,
            object: nil)
    }
    
    @objc func applicationDidBecomeActive(notification: Notification) {
        requestLocation()
    }
    
    private func requestLocation() {
        locationManager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.requestLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
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
    
}


extension TabBarController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentLocation = location
            manager.delegate = nil
            manager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        dump(error)
    }
}
