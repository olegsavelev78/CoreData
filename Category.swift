import Foundation
import RealmSwift
import Alamofire

class Category: Object {
    var main: NSDictionary?
    var weather: NSArray?
    @objc dynamic var dt_txt: String?
    @objc dynamic var temp: Double = 0.0
    convenience init?(data: NSDictionary){
        self.init()
        guard let main = data["main"] as? NSDictionary,
            let weather = data["weather"] as? NSArray,
            let temp = main["temp"] as? Double,
            let dt_txt = data["dt_txt"] as? String  else  { return }
        self.main = main
        self.weather = weather
        self.dt_txt = dt_txt
        self.temp = temp
    }
}
