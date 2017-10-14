import Foundation
import RealmSwift
import ObjectMapper


class Property: Object, Mappable {
    
    dynamic var id = 0
    dynamic var name = ""
    dynamic var image = ""
    dynamic var estate = ""
    dynamic var garea = 0
    dynamic var rent = 0
    dynamic var bedrooms = 0
    dynamic var tenants = 0
    dynamic var createdAt = ""
    dynamic var updatedAt = ""
    dynamic var latitude = ""
    dynamic var longitude = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        image <- map["imageurl"]
        estate <- map["estate"]
        garea <- map["garea"]
        rent <- map["rent"]
        bedrooms <- map["bedrooms"]
        tenants <- map["tenants"]
        createdAt <- map["createdAt"]
        updatedAt <- map["updatedAt"]
        longitude <- map["longitude"]
        latitude <- map["latitude"]
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}
