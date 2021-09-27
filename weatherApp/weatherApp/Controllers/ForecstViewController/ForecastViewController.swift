import UIKit

class ForecastViewController: WeatherViewController {
    
    private let cellReuseIdentifier = "forecastTableViewCell"

    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.ProjectColors.background
        return tableView
    }()
    
    var viewModel: ForecastViewModel? {
        didSet {
            DispatchQueue.main.async {
                self.updateView()
            }
        }
    }
    
    func updateView() {
        activityIndicatorView.stopAnimating()
        
        if let _ = viewModel {
            updateWeatherDataContainer()
        } else {
            loadingFailedLabel.isHidden = false
            loadingFailedLabel.text = "Load Location/Weather failed!"
        }
    }
    
    func updateWeatherDataContainer() {
        weatherContainerView.isHidden = false
        tableView.reloadData()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ForecastTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        setUpViews()
    }
    
    
    fileprivate func setUpViews() {
        view.backgroundColor = UIColor.ProjectColors.background
        self.navigationItem.rightBarButtonItem = self.navigationController?.makeBarButtonItem(target: self, action: #selector(appearanceButtonTapped))
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.backgroundColor = UIColor.ProjectColors.background
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


extension ForecastViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows(for: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel?.day(for: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let forecastTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! ForecastTableViewCell
        guard let viewModel = viewModel else {return forecastTableViewCell}
        
        forecastTableViewCell.configureCellWith(icon: viewModel.icon(for: indexPath.section, row: indexPath.row), timestamp: viewModel.timeStamp(for: indexPath.section, row: indexPath.row), description: viewModel.description(for: indexPath.section, row: indexPath.row), temp: viewModel.temp(for: indexPath.section, row: indexPath.row))
        
        return forecastTableViewCell
    }
}
    

extension ForecastViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    
}
