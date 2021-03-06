import UIKit

class WeatherViewController: UIViewController {
    
    let weatherContainerView = UIView()
    
    let loadingFailedLabel: UILabel = {
        let l = UILabel()
        l.backgroundColor = .red
        l.textAlignment = .center
        return l
    }()
    
    let activityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        view.addSubview(weatherContainerView)
        weatherContainerView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
        view.addSubview(loadingFailedLabel)
        loadingFailedLabel.centerX(in: view)
        loadingFailedLabel.centerY(in: view)
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.centerX(in: view)
        activityIndicatorView.centerY(in: view)
        
        weatherContainerView.isHidden = true
        loadingFailedLabel.isHidden = true
        
        activityIndicatorView.startAnimating()
        activityIndicatorView.style = .medium
        activityIndicatorView.hidesWhenStopped = true
    }
}
