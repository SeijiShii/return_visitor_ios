//
//  Place.swift
//  ReturnVisitor
//
//  Created by Seiji Shii on 2017/07/04.
//  Copyright © 2017年 SeijiShii. All rights reserved.
//

import Foundation
import GoogleMaps

class Place: DataItem {
    
    static let PLACE = "place";
    
    enum Category {
        case UNDEFINED
        case HOUSE
        case ROOM
        case HOUSING_COMPLEX
    }
    
    var latLng: CLLocationCoordinate2D
    var address: String?
    var category: Category
    var parentId: String?
    
    convenience init(latLng: CLLocationCoordinate2D, category: Category) {
        self.init()
        
        self.latLng = latLng
        self.category = category
    }
    
    override init() {
        self.latLng = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        self.category = Category.UNDEFINED
        super.init(idHeader: Place.PLACE)
    }
    
    func isAddressRequestNeeded() -> Bool {
        return address == nil || (address?.utf8.count)! <= 0
    }

    
}
