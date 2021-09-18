import Foundation

import Foundation
import UIKit

class ImageDownloadOperation: Operation {
    
    var image: UIImage?
    var complition: ((UIImage)->())?
    var url: String = ""
    
    init(with url: String) {
        super.init()
        self.url = url
    }
    
    override func main() {
        if self.isCancelled {return}
        
        guard let url = URL(string: url) else {
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if self.isCancelled {return}
            if let data = data {
                let image = UIImage(data: data)
                self.image = image
                if let complition = self.complition, let image = image {
                    complition(image)
                }
            } else {
                return
            }
        }
        if self.isCancelled {return}
        dataTask.resume()
    }
    
}

