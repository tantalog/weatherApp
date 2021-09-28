import Foundation
import UIKit

struct CurrentWeatherViewModel {
    var isLocationReady = false
    var isForecastReady = false
    
    var isUpdateReady: Bool {
        return isLocationReady && isForecastReady
    }
    
    var location: Location! {
        didSet {
            self.isLocationReady = location != nil ? true : false
        }
    }
    
    var forecast: Forecast! {
        didSet {
            self.isForecastReady = forecast != nil ? true : false
        }
    }
    
    var city: String {
        return forecast.city.name
    }
    
    var temperature: String {
        return String(Int((forecast.list.first?.main.temp)!)) + "\u{00B0}C"
    }
    
    var description: String {
        return (forecast.list.first?.weather.first!.weatherDescription)!
    }
    
    var probabilityOfPrecipitation: String {
        return String(Int(forecast.list.first!.pop) * 100) + "%"
    }
    
    var humidity: String {
        return String(forecast.list.first!.main.humidity) + "%"
    }
    
    var pressure: String {
        return String(forecast.list.first!.main.pressure) + " hPa"
    }
    
    var windSpeed: String {
        return String(forecast.list.first!.wind.speed) + " km/h"
    }
    
    var windDirection: String {
        let angle = Double(forecast.list.first!.wind.deg)
        let direction = angle.direction.description
        return direction
    
    }
    
    var icon: UIImage {
        return UIImage.weatherIcon(of: forecast.list.first!.weather.first!.icon)!
    }
    
    
}
