import UIKit

class CurrentWeatherViewController: WeatherViewController {
    
    
    let forecastViewController = ForecastViewController()
    let mainScrollView: UIScrollView = {UIScrollView()}()
    var conditionIcon = UIImageView()
    var cityLabel = ProjectStyleLabel()
    var tempLabel = ProjectStyleLabel(fontSize: 48)
    var descriptionLabel = ProjectStyleLabel(textColor: UIColor.ProjectColors.descriptionText)
    var probabilityOfPrecipitationLabel = ProjectStyleLabel()
    var probabilityOfPrecipitationIcon =   makeIconImageView(systemName: IconNames.pop.rawValue)
    var humidityLabel = ProjectStyleLabel()
    var humidityIcon =   makeIconImageView(systemName: IconNames.humidity.rawValue)
    var pressureLabel = ProjectStyleLabel()
    var pressureIcon = makeIconImageView(systemName: IconNames.pressure.rawValue)
    var windSpeedLabel = ProjectStyleLabel()
    var windSpeedIcon = makeIconImageView(systemName: IconNames.windSpeed.rawValue)
    var windDirectionLabel = ProjectStyleLabel()
    var windDirectionIcon = makeIconImageView(systemName: IconNames.windDirection.rawValue)
    var messageToShare: String?
    
    var shareButton = UIButton()
    
    var viewModel: CurrentWeatherViewModel? {
        didSet {
            DispatchQueue.main.async { self.updateView() }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Today"
        self.navigationItem.rightBarButtonItem = self.navigationController?.makeBarButtonItem(target: self, action: #selector(appearanceButtonTapped))
        view.backgroundColor = UIColor.ProjectColors.background
        setShareButton()
        setUpViews()
    }
    
    func updateView() {
        activityIndicatorView.stopAnimating()
        
        if let vm = viewModel, vm.isUpdateReady {
            updateWeatherContainer(with: vm)
        } else {
            loadingFailedLabel.isHidden = false
            loadingFailedLabel.text = "Fetch weather/location failed."
        }
    }
    
    func updateWeatherContainer(with vm: CurrentWeatherViewModel) {
        weatherContainerView.isHidden = false
        loadingFailedLabel.isHidden = true
        
        cityLabel.text = vm.city
        tempLabel.text = vm.temperature
        descriptionLabel.text = vm.description
        probabilityOfPrecipitationLabel.text = vm.probabilityOfPrecipitation
        humidityLabel.text = vm.humidity
        pressureLabel.text = vm.pressure
        windSpeedLabel.text = vm.windSpeed
        windDirectionLabel.text = vm.windDirection
        conditionIcon.image = vm.icon
        messageToShare = """
        location: \(vm.city)
        temp: \(vm.temperature)
        description: \(vm.description)
        probability of precipitation: \(vm.probabilityOfPrecipitation)
        humidity: \(vm.humidity)
        pressure: \(vm.pressure)
        wind speed: \(vm.windSpeed)
"""
        
    }
    
    
    fileprivate func setUpViews() {
        
        conditionIcon.contentMode = .scaleAspectFill
        conditionIcon.clipsToBounds = true
        
        view.addSubview(mainScrollView)
        
        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint .activate([mainScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                      mainScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                      mainScrollView.topAnchor.constraint(equalTo: view.topAnchor),
                                      mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        
        
        let centralStackView = setVerticalStackView(views: [cityLabel, tempLabel, descriptionLabel], spacing: 10)
        
        let popStackView = setVerticalStackView(views: [probabilityOfPrecipitationIcon, probabilityOfPrecipitationLabel], spacing: 10)
        let rainVolumeStackView = setVerticalStackView(views: [humidityIcon, humidityLabel], spacing: 10)
        let pressureStackView = setVerticalStackView(views: [pressureIcon, pressureLabel], spacing: 10)
        let firstRowStackView = setHorizontalStackView(views: [popStackView, rainVolumeStackView, pressureStackView], spacing: 70)
        
        let  windSpeedStackView = setVerticalStackView(views: [windSpeedIcon, windSpeedLabel])
        let windDirectionStackView = setVerticalStackView(views: [windDirectionIcon, windDirectionLabel])
        let secondRowStackView = setHorizontalStackView(views: [windSpeedStackView, windDirectionStackView])
        let dataStackView = setVerticalStackView(views: [firstRowStackView, secondRowStackView], spacing: 20, alignment: .firstBaseline)
        
        let verticalStackView = setVerticalStackView(views: [conditionIcon, centralStackView, dataStackView], spacing: 50)
        mainScrollView.addSubview(verticalStackView)
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.topAnchor.constraint(equalTo: mainScrollView.topAnchor, constant: 10).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: shareButton.topAnchor,constant: -50).isActive = true
        NSLayoutConstraint.activate([verticalStackView.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor),
                                     verticalStackView.widthAnchor.constraint(equalTo: view.widthAnchor)])
        setShareButton()
        
    }
    
    func setShareButton() {
        mainScrollView.addSubview(shareButton)
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor).isActive = true
        shareButton.widthAnchor.constraint(equalTo: mainScrollView.widthAnchor).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: 26).isActive = true
        shareButton.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor, constant: -100).isActive = true
        shareButton.setTitle("Share", for: .normal)
        shareButton.titleLabel?.textAlignment = .center
        shareButton.setTitleColor(.systemBlue, for: .normal)
        shareButton.titleLabel?.backgroundColor = .none
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
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
    
    @objc func shareButtonTapped(_ sender: UIButton) {
        let textToShare = [messageToShare]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
}
