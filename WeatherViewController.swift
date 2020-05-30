import UIKit
import Alamofire
import RealmSwift

class WeatherViewController: UIViewController {
    
    var categories: Results<Category>!
    var realm: Realm!
        
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
            super.viewDidLoad()
        
        print("Download ViewController complete")
        
        realm = try! Realm()
        
        CategoriesLoaded2().loadCategories { category,nameCity,tempToday in
            self.tableView.reloadData()
            self.cityNameLabel.text = nameCity
            self.tempLabel.text = "\(Int(tempToday)) C°"
            
            Persistance2.shared.userName = nameCity
            Persistance2.shared.weatherName = "\(Int(tempToday)) C°"
        }
        self.categories = realm.objects(Category.self)
        cityNameLabel.text = Persistance2.shared.userName
        tempLabel.text = Persistance2.shared.weatherName
        }
}

    extension WeatherViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return categories.count
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NameCell") as! NameTableViewCell
            
            let category = self.categories[indexPath.row]
            
            cell.nameLabel.text = category.dt_txt
            cell.weatherLabel.text = "\(Int(category.temp)) C°"
            
            return cell
        }
        
}


