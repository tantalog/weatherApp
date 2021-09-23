import UIKit

class ForecastViewController: UIViewController {
    
    var days: [String] = []
    var icons: [UIImage] = []
    var timestamps: [String] = []
    var descriptions: [String] = []
    var temps: [String] = []
    var forecast: List?
    var forecastTuple : ([String], [UIImage], [String], [String], [String])? = nil

    private var viewModel: ViewModel = ViewModel()
    private let cellReuseIdentifier = "forecastTableViewCell"
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.ProjectColors.background
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ForecastTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        setUpViews()
        viewModel.configLocation()
        viewModel.startLoading() {
            configireUI()
            print(days)
        }
    }
    
    
    fileprivate func setUpViews() {
        view.backgroundColor = UIColor.ProjectColors.background
        self.navigationItem.rightBarButtonItem = self.navigationController?.makeBarButtonItem(target: self, action: #selector(appearanceButtonTapped))
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func configireUI()  {
        
        self.navigationItem.title = viewModel.city.value
        
//            self.viewModel.city.bind { (text) in self.navigationItem.title = text }
            self.viewModel.days.bind { (stringsArray) in self.days = stringsArray }
            self.viewModel.icons.bind { (imagesArray) in self.icons = imagesArray }
            self.viewModel.timestamps.bind { (stringsArray) in self.timestamps = stringsArray }
            self.viewModel.descriptions.bind { (stringsArray) in self.descriptions = stringsArray }
            self.viewModel.temps.bind { (stringsArray) in self.temps = stringsArray }
    }
    
//    func configireUI()  {
//            self.viewModel.city.bind { (text) in self.navigationItem.title = text }
//            self.viewModel.days.bind { (stringsArray) in self.days = stringsArray }
//            self.viewModel.icons.bind { (imagesArray) in self.icons = imagesArray }
//            self.viewModel.timestamps.bind { (stringsArray) in self.timestamps = stringsArray }
//            self.viewModel.descriptions.bind { (stringsArray) in self.descriptions = stringsArray }
//            self.viewModel.temps.bind { (stringsArray) in self.temps = stringsArray }
//    }
    
//    private func bindForecastTuple() {
//        viewModel.city.bind { (text) in
//            self.navigationItem.title = text
//        }
//        viewModel.days.bind { array in
//            self.days = array
//        }
//
//        viewModel.tuple?.bind({ (tuple) in
//            self.forecastTuple = tuple
//        })
//    }
    
    
    
    
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        viewModel.timestamps.bind({ (array) in
            count = array.count
        })
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let forecastTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! ForecastTableViewCell
       
        viewModel.icons.bind { images in
            forecastTableViewCell.iconImageView.image = images[indexPath.row]
        }
        viewModel.timestamps.bind { array in
            forecastTableViewCell.timeLabel.text = array[indexPath.row]
        }
        viewModel.descriptions.bind { array in
            forecastTableViewCell.descriptionLabel.text = array[indexPath.row]
        }
        viewModel.temps.bind { array in
            forecastTableViewCell.tempretureLabel.text = array[indexPath.row]
        }

        return forecastTableViewCell
    }
}
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let forecastTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! ForecastTableViewCell
//        viewModel.tuple?.bind({ (tuple) in
//            forecastTableViewCell.iconImageView.image = tuple.1[indexPath.row]
//            forecastTableViewCell.timeLabel.text = tuple.2[indexPath.row]
//            forecastTableViewCell.descriptionLabel.text = tuple.3[indexPath.row]
//            forecastTableViewCell.tempretureLabel.text = tuple.4[indexPath.row]
//        })
//
//        return forecastTableViewCell
//    }
//}


extension ForecastViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    
}
