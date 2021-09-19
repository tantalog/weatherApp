import Foundation
import CoreLocation
import UIKit

class ViewModel: NSObject, CLLocationManagerDelegate {
    
    var latitude: String = "55.5"
    var longitude: String = "37.5"
    var currentWeather: Bindable<CurrentWeather>?
    var weather: CurrentWeather?
    var icon: Bindable<UIImage>?
    var alert: UIAlertController?
    private var locationManager = CLLocationManager()
    private var coordinate: CLLocationCoordinate2D?
    
    func configLocation() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let location = manager.location?.coordinate else {return}
//        print("locations = \(location.latitude) \(location.longitude)")
        self.latitude = String(location.latitude)
        self.longitude = String(location.longitude)
    }
    
    
    func startLoading() {
        let parser = Parser()
        let networkingService = NetworkingService(with: parser)
        networkingService.loadWeather (latitude: latitude, longitude: longitude) { (weatherData, error) in
            DispatchQueue.main.async {
                if let error = error {
                    let alert = UIAlertController(title: "Alert",
                                                  message: "\(error)",
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK",
                                                  style: .default,
                                                  handler: nil))
                    self.alert = alert
                }
                else {
                    guard let weatherData = weatherData else {return}
                    self.currentWeather?.value = weatherData
                    self.weather = weatherData
                    print(weatherData)
                    if let icon = self.weather?.weather.first?.icon {
                        networkingService.loadImageForURL(url: ("http://openweathermap.org/img/wn/" + icon + "@2x.png"))  { (image) in
                            DispatchQueue.main.async {
                                self.icon?.value = image
                            }
                        }
                    }
                }
            }
        }
    }
    
   
}

