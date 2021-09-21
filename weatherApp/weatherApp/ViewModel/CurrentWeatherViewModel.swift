import Foundation
import CoreLocation
import UIKit

class ViewModel: NSObject, CLLocationManagerDelegate {
    
    var latitude: String = "55.5"
    var longitude: String = "37.5"
    var forecast: Forecast?
    var icon: Bindable<UIImage> = Bindable(UIImage())
    var city: Bindable<String> = Bindable("")
    var temp: Bindable<String> = Bindable("")
    var weatherDescription: Bindable<String> = Bindable("")
    var humidity: Bindable<String> = Bindable("")
    var probabilityOfPrecipitation: Bindable<String> = Bindable("")
    var pressure: Bindable<String> = Bindable("")
    var windSpeed: Bindable<String> = Bindable("")
    var windDirection: Bindable<String> = Bindable("")
    
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
        self.latitude = String(location.latitude)
        self.longitude = String(location.longitude)
    }
    
    
    func startLoading() {
        let parser = Parser()
        let networkingService = NetworkingService(with: parser)
        networkingService.loadForecast (latitude: latitude, longitude: longitude) { (forecastData, error) in
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
                    guard let forecastData = forecastData else {return}
                    self.city.value = forecastData.city.name + ", " + forecastData.city.country
                    if let currentWeather = forecastData.list.first {
                        self.temp.value = String(Int(currentWeather.main.temp)) + "\u{00B0}C"
                        if let firstWeather = currentWeather.weather.first {
                            self.weatherDescription.value = firstWeather.weatherDescription
                        }
                        self.humidity.value = String(currentWeather.main.humidity) + "%"
                        self.probabilityOfPrecipitation.value = String(Int(currentWeather.pop) * 100) + "%"
                        self.pressure.value = String(currentWeather.main.pressure) + " hPa"
                        self.windSpeed.value = String(currentWeather.wind.speed) + " km/h"
                        self.windDirection.value = String(currentWeather.wind.deg)
                        
                        if let icon = currentWeather.weather.first?.icon {
                            networkingService.loadImageForURL(url: ("http://openweathermap.org/img/wn/" + icon + "@2x.png"))  { (image) in
                                DispatchQueue.main.async {
                                    self.icon.value = image
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
