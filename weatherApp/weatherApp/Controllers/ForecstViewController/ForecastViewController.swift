import UIKit

class ForecastViewController: UIViewController {
    
    private var viewModel: ViewModel = ViewModel()
    private let cellReuseIdentifier = "forecastTableViewCell"

    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.ProjectColors.background
        return tableView
    }()
    
   
    var days: [String] = []
    var icons: [UIImage] = []
    var timestamps: [String] = []
    var descriptions: [String] = []
    var temps: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ForecastTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        viewModel.configLocation()
//        viewModel.startLoading()
        setUpViews()
//        getData {
//            tableView.reloadData()
//        }
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
    
    func getData(complition: ()->()) {
        self.viewModel.timestamps.bind({ (timestamps) in
            self.timestamps = timestamps
        })
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timestamps.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return days[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let forecastTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! ForecastTableViewCell
        forecastTableViewCell.configureCellWith(icon: icons[indexPath.row], timestamp: timestamps[indexPath.row], description: descriptions[indexPath.row], temp: temps[indexPath.row])
        return forecastTableViewCell
    }
}
    

extension ForecastViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    
}
