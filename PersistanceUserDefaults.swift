import Foundation

class Persistance{
    static var shared = Persistance()
    
    private let kUserNameKey = "Persistance.kUserNameKey"
    var userName: String? {
        set { UserDefaults.standard.set(newValue, forKey: kUserNameKey)}
        get { return UserDefaults.standard.string(forKey: kUserNameKey)}
    }
    
    private let kUserSecondNameKey = "Persistance.kUserSecondNameKey"
    var userSecondName: String? {
        set { UserDefaults.standard.set(newValue, forKey: kUserSecondNameKey)}
        get { return UserDefaults.standard.string(forKey: kUserSecondNameKey)}
    }

}
