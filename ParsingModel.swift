import Foundation
import Alamofire
import RealmSwift

class CategoriesLoaded2{
    func loadCategories(completion: @escaping (Category, String, Double) -> Void){
        AF.request("https://api.openweathermap.org/data/2.5/forecast?id=524901&units=metric&lang=ru&appid=8c7a6ca664ebabcedf6971954e610463").responseJSON { response in
            if let object = response.value,
            let jsonDict = object as? NSDictionary{
                let category = Category()
                
                let array = jsonDict["list"] as! NSArray
                for item in array {
                    if let category = Category(data: item as! NSDictionary)
                    {
                        PersistanceRealm2.shared.test(array: category)
                    }
                }
                let tempArray = jsonDict["list"] as! NSArray
                    let tempDict = tempArray[0] as! NSDictionary
                        let tempArray2 = tempDict["main"] as! NSDictionary
                            let tempToday = tempArray2["temp"] as! Double
                
                let cityDict = jsonDict["city"] as! NSDictionary
                let nameCity = cityDict["name"] as! String
                
                DispatchQueue.main.async {
                    completion(category, nameCity, tempToday)
                }
        }
        }
    }
}
