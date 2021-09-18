import Foundation

class Parser {
    
    func parseWeather(_ data: Data, complition:  @escaping ([CurrentWeather]?, Error?) -> ()  ) {
        let rockets = try! JSONDecoder().decode([CurrentWeather].self, from: data) as [CurrentWeather]
        complition(rockets,nil)
    }
}
