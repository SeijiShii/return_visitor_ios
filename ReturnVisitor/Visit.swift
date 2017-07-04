//
//  Visit.swift
//  ReturnVisitor
//
//  Created by Seiji Shii on 2017/07/04.
//  Copyright © 2017年 SeijiShii. All rights reserved.
//

import Foundation
class Visit: DataItem {
    
    static let VISIT = "visit"
    
    var dateTime: Date
    var placeId: String
    var visitDetails : NSMutableArray
    var placements: NSMutableArray
    
    init(placeId: String) {
        self.placeId = placeId
        self.dateTime = Date()
        self.visitDetails = NSMutableArray()
        self.placements = NSMutableArray()
        
        super.init(idHeader: Visit.VISIT)
    }
    
    init(lastVisit: Visit) {
        self.placeId = lastVisit.placeId
        self.dateTime = Date()
        self.visitDetails = NSMutableArray()
        for detail in lastVisit.visitDetails {
            self.visitDetails.add(VisitDetail(lastVisitDetail: detail as! VisitDetail))
        }
     
        self.placements = NSMutableArray()
        
        super.init(idHeader: Visit.VISIT)
    }
    
    
    
}
