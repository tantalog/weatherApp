import Foundation

enum DataManagerError: Error {
    case failedRequest
    case invalidResponse
    case unknown
}

final class ForecastManager {
    
    internal init() {}

    static let shared = ForecastManager()
    
    typealias CompletionHandler = (Forecast?, DataManagerError?) -> Void
    
    func forecastAt(latitude: Double, longitude: Double, completion: @escaping CompletionHandler) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&units=metric&appid=f0cfe7251fba12244ee19e5184cf7eb5") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: {
            (data, response, error) in
            self.didFinishGettingForecast(data: data, response: response, error: error, completion: completion)
        }).resume()
    }
    
    func didFinishGettingForecast(data: Data?, response: URLResponse?, error: Error?, completion: CompletionHandler) {
        if let _ = error {
            completion(nil, .failedRequest)
        } else if let data = data, let response = response as? HTTPURLResponse {
            if response.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
//                    decoder.dateDecodingStrategy = .secondsSince1970
                    let forecast = try decoder.decode(Forecast.self, from: data)
                    completion(forecast, nil)
                } catch {
                    completion(nil, .invalidResponse)
                }
            } else {
                completion(nil, .failedRequest)
            }
        } else {
            completion(nil, .unknown)
        }
    }
}
