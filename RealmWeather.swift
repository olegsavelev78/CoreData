import Foundation
import RealmSwift

class PersistanceRealm2 {
    static let shared = PersistanceRealm2()
    
    let realm = try! Realm()

    func test(array: Category){
        
        try! realm.write {
            realm.add(array)
        }
    }

}
