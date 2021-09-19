import UIKit

class CurrentWeatherViewController: UIViewController {
    
    var cityLabel = ProjectStyleLabel()
    var tempLabel = ProjectStyleLabel()
    var descriptionLabel = ProjectStyleLabel()
    
    
    
    var weather: CurrentWeather?
    var icon = UIImageView()
    var titleLabel = ProjectStyleLabel(text: "Today", fontSize: 24)
    
    
    private var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Today"
        self.navigationItem.rightBarButtonItem = self.navigationController?.makeBarButtonItem(target: self, action: #selector(appearanceButtonTapped))
        view.backgroundColor = UIColor.ProjectColors.background
        viewModel.configLocation()
        viewModel.startLoading()
//                setUpViews()
        configireUI()
    }
    
    func setUpViews() {
        view.addSubview(titleLabel)
        NSLayoutConstraint .activate([titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                      titleLabel.widthAnchor.constraint(equalToConstant: 140),
                                      titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
                                      titleLabel.heightAnchor.constraint(equalToConstant: 28)])
        titleLabel.textAlignment = .center
        
        let verticalStackView = setVerticalStackView(views: [icon, titleLabel,cityLabel, tempLabel, descriptionLabel])
        view.addSubview(verticalStackView)
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([verticalStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
                                     verticalStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                     verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
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
