import Foundation
import UIKit


struct ForecastViewModel {
    
    let list: [List]
    
    func day(for section: Int) ->String {
        var daysArray = [String]()
        for timestampForecast in list {
            guard let dayOfTheWeek = getDayOfWeek(date: timestampForecast.dtTxt) else {return ""}
            if daysArray.isEmpty {
                daysArray.append(dayOfTheWeek)
            }
            if dayOfTheWeek != daysArray.last {
                daysArray.append(dayOfTheWeek)
            }
        }
        daysArray.remove(at: 0)
        daysArray.insert("Today", at: 0)
        return daysArray[section]
    }
    
    func timeStamp(for section: Int, row: Int) -> String {
        var index = 0
        var daysArray = [String]()
        var timestampsArray: [[String]] = [[],[],[],[],[],[]]
        for timestampForecast in list {
            guard let dayOfTheWeek = getDayOfWeek(date: timestampForecast.dtTxt) else {return ""}
            if daysArray.isEmpty {
                daysArray.append(dayOfTheWeek)
            }
            if dayOfTheWeek != daysArray.last {
                daysArray.append(dayOfTheWeek)
                index += 1
            }
            timestampsArray[index].append(timestampForecast.dtTxt)
        }
        let timestamp =  timestampsArray[section][row]
        return formatTime(date: timestamp)
    }
    
    func description(for section: Int, row: Int) -> String {
        var index = 0
        var daysArray = [String]()
        var descriptionsArray: [[String]] = [[],[],[],[],[],[]]
        for timestampForecast in list {
            guard let dayOfTheWeek = getDayOfWeek(date: timestampForecast.dtTxt) else {return ""}
            if daysArray.isEmpty {
                daysArray.append(dayOfTheWeek)
            }
            if dayOfTheWeek != daysArray.last {
                daysArray.append(dayOfTheWeek)
                index += 1
            }
            descriptionsArray[index].append(timestampForecast.weather.first!.weatherDescription)
        }
        return descriptionsArray[section][row]
    }
    
    func temp(for section: Int, row: Int) -> String {
        var index = 0
        var daysArray = [String]()
        var tempsArray: [[Double]] = [[],[],[],[],[],[]]
        for timestampForecast in list {
            guard let dayOfTheWeek = getDayOfWeek(date: timestampForecast.dtTxt) else {return ""}
            if daysArray.isEmpty {
                daysArray.append(dayOfTheWeek)
            }
            if dayOfTheWeek != daysArray.last {
                daysArray.append(dayOfTheWeek)
                index += 1
            }
            tempsArray[index].append(timestampForecast.main.temp)
        }
        return String(Int(tempsArray[section][row])) + "\u{00B0}C"
    }
    
    func icon(for section: Int, row: Int) -> UIImage {
        var index = 0
        var daysArray = [String]()
        var iconNamesArray: [[String]] = [[],[],[],[],[],[]]
        for timestampForecast in list {
            guard let dayOfTheWeek = getDayOfWeek(date: timestampForecast.dtTxt) else {return UIImage()}
            if daysArray.isEmpty {
                daysArray.append(dayOfTheWeek)
            }
            if dayOfTheWeek != daysArray.last {
                daysArray.append(dayOfTheWeek)
                index += 1
            }
            iconNamesArray[index].append(timestampForecast.weather.first!.icon)
        }
        return UIImage.weatherIcon(of: iconNamesArray[section][row])!
    }
    

    var numberOfSections: Int {
        return 5
    }
    func numberOfRows(for section: Int) -> Int {
        var index = 0
        var daysArray = [String]()
        var timestampsArray: [[String]] = [[],[],[],[],[],[]]
        for timestampForecast in list {
            guard let dayOfTheWeek = getDayOfWeek(date: timestampForecast.dtTxt) else {return 0}
            if daysArray.isEmpty {
                daysArray.append(dayOfTheWeek)
            }
            if dayOfTheWeek != daysArray.last {
                daysArray.append(dayOfTheWeek)
                index += 1
            }
            timestampsArray[index].append(timestampForecast.dtTxt)
        }
        return timestampsArray[section].count
    }
    
    
   private func getDayOfWeek(date: String) -> String? {
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
    
    private func formatTime(date: String) -> String {
         let dateFormatterGet = DateFormatter()
         dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
         let dateDate = dateFormatterGet.date(from: date)
         let dateFormatterReturn = DateFormatter()
         dateFormatterReturn.dateFormat = "HH:mm"
         if let dateDate = dateDate {
             return dateFormatterReturn.string(from: dateDate)
         }
         return ""
     }
    
    
}
