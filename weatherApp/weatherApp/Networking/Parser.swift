import Foundation

class Parser {
    
    func parseForecast(_ data: Data, complition:  @escaping (Forecast?, Error?) -> ()  ) {
        let forecast = try! JSONDecoder().decode(Forecast.self, from: data) as Forecast
        complition(forecast,nil)
    }
    
    func parseCity(_ data: Data, complition:  @escaping (City?, Error?) -> ()  ) {
        let city = try! JSONDecoder().decode(City.self, from: data) as City
        complition(city,nil)
    }
}
