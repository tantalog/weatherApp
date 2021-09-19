import UIKit

class CurrentWeatherViewController: UIViewController {
    
    var icon = UIImageView()
    var cityLabel = ProjectStyleLabel()
    var tempLabel = ProjectStyleLabel()
    var descriptionLabel = ProjectStyleLabel()
    var humidityLabel = ProjectStyleLabel()
    var humidityIcon =   makeIconImageView(systemName: IconNames.humidity.rawValue)
    var pressureLabel = ProjectStyleLabel()
    var pressureIcon = makeIconImageView(systemName: IconNames.pressure.rawValue)
    var windSpeedLabel = ProjectStyleLabel()
    var windSpeedIcon = makeIconImageView(systemName: IconNames.windSpeed.rawValue)
    var windDirectionLabel = ProjectStyleLabel()
    var windDirectionIcon = makeIconImageView(systemName: IconNames.windDirection.rawValue)
    
    var shareButton = UIButton()
    
    
    
    
    var weather: CurrentWeather?

    
    private var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Today"
        self.navigationItem.rightBarButtonItem = self.navigationController?.makeBarButtonItem(target: self, action: #selector(appearanceButtonTapped))
        view.backgroundColor = UIColor.ProjectColors.background
        viewModel.configLocation()
        viewModel.startLoading()
                setUpViews()
        configireUI()
    }
    
    func setUpViews() {

        let verticalStackView = setVerticalStackView(views: [humidityIcon ,pressureIcon, windSpeedIcon, windSpeedLabel])
        view.addSubview(verticalStackView)
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([verticalStackView.topAnchor.constraint(equalTo: view.topAnchor),
                                     verticalStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                     verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
        verticalStackView.backgroundColor = .brown
    }
    

    
    func configireUI() {
        if let icon = viewModel.icon {
            icon.bind { (image) in
                self.icon.image = image
            }
        }
        
        if let weather = viewModel.currentWeather {
            weather.bind { (image) in
                self.cityLabel.text = weather.value.name
                self.tempLabel.text = String(weather.value.main.temp)
            }
        }
            
    }
    
    @objc func appearanceButtonTapped() {
        switch overrideUserInterfaceStyle {
        case .dark:
            overrideUserInterfaceStyle = .light
            self.navigationController?.overrideUserInterfaceStyle = .light
            self.tabBarController?.overrideUserInterfaceStyle = .light
        default:
            overrideUserInterfaceStyle = .dark
            self.navigationController?.overrideUserInterfaceStyle = .dark
            self.tabBarController?.overrideUserInterfaceStyle = .dark
        }
    }
    
    
    
    
    
    
    
    
    
    
}
