import Foundation
import RealmSwift
import ObjectMapper

class Property: Object, Mappable {
    
    dynamic var id = 0
    dynamic var name = ""
    dynamic var image = ""
    dynamic var estate = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        image <- map["imageurl"]
        estate <- map["estate"]
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}
