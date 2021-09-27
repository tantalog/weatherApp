import Foundation
import UIKit

class ViewModel: NSObject {
    
//    var latitude: String = "55.5"
//    var longitude: String = "37.5"

    var icon: Bindable<UIImage> = Bindable(UIImage())
    var city: Bindable<String> = Bindable("")
    var temp: Bindable<String> = Bindable("")
    var weatherDescription: Bindable<String> = Bindable("")
    var humidity: Bindable<String> = Bindable("")
    var probabilityOfPrecipitation: Bindable<String> = Bindable("")
    var pressure: Bindable<String> = Bindable("")
    var windSpeed: Bindable<String> = Bindable("")
    var windDirection: Bindable<String> = Bindable("")
    
    var days: Bindable<[String]> = Bindable([String]())
    
    var icons: Bindable<[UIImage]> = Bindable([UIImage]())
    var timestampsArray: Bindable<[[String]]> = Bindable([[String]]())
    var descriptionsArray: Bindable<[[String]]> = Bindable([[String]]())
    var tempsArray: Bindable<[[String]]> = Bindable([[String]]())
    
    var alert: UIAlertController?
    
    
//    func startLoading(latitude: String, longitude: String) {
//        let parser = Parser()
//        let networkingService = NetworkingService(with: parser)
//        networkingService.loadForecast (latitude: latitude, longitude: longitude) { (forecastData, error) in
//            DispatchQueue.main.async { [self] in
//                if let error = error {
//                    let alert = UIAlertController(title: "Alert",
//                                                  message: "\(error)",
//                                                  preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "OK",
//                                                  style: .default,
//                                                  handler: nil))
//                    self.alert = alert
//                }
//                else {
//                    guard let forecastData = forecastData else {return}
//                    self.city.value = forecastData.city.name + ", " + forecastData.city.country
//                    if let currentWeather = forecastData.list.first {
//                        self.temp.value = String(Int(currentWeather.main.temp)) + "\u{00B0}C"
//                        if let firstWeather = currentWeather.weather.first {
//                            self.weatherDescription.value = firstWeather.weatherDescription
//                        }
//                        self.humidity.value = String(currentWeather.main.humidity) + "%"
//                        self.probabilityOfPrecipitation.value = String(Int(currentWeather.pop) * 100) + "%"
//                        self.pressure.value = String(currentWeather.main.pressure) + " hPa"
//                        self.windSpeed.value = String(currentWeather.wind.speed) + " km/h"
//                        self.windDirection.value = String(currentWeather.wind.deg)
//                        
//                        if let icon = currentWeather.weather.first?.icon {
//                            networkingService.loadImageForURL(url: ("http://openweathermap.org/img/wn/" + icon + "@2x.png"))  { (image) in
//                                DispatchQueue.main.async {
//                                    self.icon.value = image
//                                }
//                            }
//                        }
//                    }
//                    var index = 0
//                    var daysArray = [String]()
//                    var timestampsArray: [[String]] = [[],[],[],[],[],[]]
//                    var descriptionsArray: [[String]] = [[],[],[],[],[],[]]
//                    var tempsArray: [[String]] = [[],[],[],[],[],[]]
//                    var iconsArray: [[UIImage]] = [[],[],[],[],[],[]]
//                    for timestampForecast in forecastData.list {
//                        guard let dayOfTheWeek = getDayOfWeek(date: timestampForecast.dtTxt) else {return}
//                        if daysArray.isEmpty {
//                            daysArray.append(dayOfTheWeek)
//                        }
//                        if dayOfTheWeek != daysArray.last {
//                            daysArray.append(dayOfTheWeek)
//                            index += 1
//                        }
//                        timestampsArray[index].append(timestampForecast.dtTxt)
//                        tempsArray[index].append(String(Int(timestampForecast.main.temp)) + "\u{00B0}C")
//                        if let timestampWeather = timestampForecast.weather.first {
//                            descriptionsArray[index].append(timestampWeather.weatherDescription)
//                            networkingService.loadImageForURL(url: ("http://openweathermap.org/img/wn/" + timestampWeather.icon + "@2x.png"))  { (image) in
//                                DispatchQueue.main.async {
//                                    self.icons.value.append(image)
//                                    iconsArray[index].append(image)
//                                }
//                            }
//                        }
//                    }
//                    daysArray.remove(at: 0)
//                    daysArray.insert("Today", at: 0)
//                    self.days.value = daysArray
//                    self.timestampsArray.value = timestampsArray
//                    self.descriptionsArray.value = descriptionsArray
//                    self.tempsArray.value = tempsArray
//                }
//            }
//        }
//    }
    
    
    func getDayOfWeek(date: String) -> String? {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateDate = dateFormatterGet.date(from: date)
        let dateFormatterReturn = DateFormatter()
        dateFormatterReturn.dateFormat = "EEEE"
        if let dateDate = dateDate {
            return dateFormatterReturn.string(from: dateDate)
        }
        return nil
    }
    
}
