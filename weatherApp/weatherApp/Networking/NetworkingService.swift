import Foundation
import UIKit

class NetworkingService {
    var parser: Parser
    var queue: OperationQueue
    var operations: [String: [Operation]]
    
    init(with parser: Parser) {
        self.parser = parser
        self.queue = OperationQueue()
        self.operations = [String: [Operation]]()
    }
    
    func loadRockets(complition:@escaping ([CurrentWeather]?, Error?)->()) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q={minsk}&appid={98bbf81fe08173c6a80a9db6cf363ee6}") else {return}
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if (error != nil) {
                return
            }
            self.parser.parseWeather(data!, complition: complition)
        }
        task.resume()
    }
    
    func loadImageForURL(url: String, complition: @escaping (UIImage)->()) {
        cancelDownloadingForUrl(url: url)
        let operation = ImageDownloadOperation(with: url)
        operations[url] = [operation]
        operation.complition = complition
        self.queue.addOperation(operation)
    }
    
    func cancelDownloadingForUrl(url: String) {
        if let operations: [Operation] = self.operations[url] {
            for operation in operations {
                operation.cancel()
            }
        }
    }
}
