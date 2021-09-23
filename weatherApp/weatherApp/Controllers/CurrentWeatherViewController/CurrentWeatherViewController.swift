import UIKit

class CurrentWeatherViewController: UIViewController {
    
    let mainScrollView: UIScrollView = {UIScrollView()}()
    var conditionIcon = UIImageView()
    var cityLabel = ProjectStyleLabel(text: "Minsk, BY")
    var tempLabel = ProjectStyleLabel(text: "28\u{00B0}C", fontSize: 48)
    var descriptionLabel = ProjectStyleLabel(text:"light intensity drizzle", textColor: UIColor.ProjectColors.descriptionText)
    var probabilityOfPrecipitationLabel = ProjectStyleLabel(text: "95%")
    var probabilityOfPrecipitationIcon =   makeIconImageView(systemName: IconNames.pop.rawValue)
    var humidityLabel = ProjectStyleLabel(text: "3400 m")
    var humidityIcon =   makeIconImageView(systemName: IconNames.humidity.rawValue)
    var pressureLabel = ProjectStyleLabel(text: "1015 hPa")
    var pressureIcon = makeIconImageView(systemName: IconNames.pressure.rawValue)
    var windSpeedLabel = ProjectStyleLabel(text: "8 km/h")
    var windSpeedIcon = makeIconImageView(systemName: IconNames.windSpeed.rawValue)
    var windDirectionLabel = ProjectStyleLabel(text: "SE")
    var windDirectionIcon = makeIconImageView(systemName: IconNames.windDirection.rawValue)
    
    var shareButton = UIButton()
//    var forecast: Forecast?
    
    private var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Today"
        self.navigationItem.rightBarButtonItem = self.navigationController?.makeBarButtonItem(target: self, action: #selector(appearanceButtonTapped))
        view.backgroundColor = UIColor.ProjectColors.background
        viewModel.configLocation()
        viewModel.startLoading() {
            configireUI()
        }

        setShareButton()
        setUpViews()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        
    }
    
    fileprivate func setUpViews() {
        
        
        conditionIcon = UIImageView(image: UIImage(named: "mockWeatherIcon"))
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
    }
    
    
    
    func configireUI() {
        self.viewModel.icon.bind { (image) in self.conditionIcon.image = image }
        self.viewModel.city.bind { (text) in self.cityLabel.text = text }
        self.viewModel.temp.bind { (text) in self.tempLabel.text = text }
        self.viewModel.weatherDescription.bind { (text) in self.descriptionLabel.text = text }
        self.viewModel.humidity.bind { (text) in self.humidityLabel.text = text }
        self.viewModel.probabilityOfPrecipitation.bind { (text) in self.probabilityOfPrecipitationLabel.text = text }
        self.viewModel.pressure.bind { (text) in self.pressureLabel.text = text }
        self.viewModel.windSpeed.bind { (text) in self.windSpeedLabel.text = text }
        self.viewModel.windDirection.bind { (text) in self.windDirectionLabel.text = text }
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
