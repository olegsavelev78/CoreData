import Foundation

class Persistance2{
    static var shared = Persistance2()
    
    private let kUserNameKey = "Persistance2.kUserNameKey"
    var userName: String? {
        set { UserDefaults.standard.set(newValue, forKey: kUserNameKey)}
        get { return UserDefaults.standard.string(forKey: kUserNameKey)}
    }
    
    private let kWeatherNameKey = "Persistance2.kUserSecondNameKey"
    var weatherName: String? {
        set { UserDefaults.standard.set(newValue, forKey: kWeatherNameKey)}
        get { return UserDefaults.standard.string(forKey: kWeatherNameKey)}
    }
}
