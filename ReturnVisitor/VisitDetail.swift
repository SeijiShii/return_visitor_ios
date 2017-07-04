//
//  VisitDetail.swift
//  ReturnVisitor
//
//  Created by Seiji Shii on 2017/07/04.
//  Copyright © 2017年 SeijiShii. All rights reserved.
//

import Foundation
class VisitDetail: DataItem {
    
    static let VISIT_DETAIL = "visit_detail"
    
    var visitId, personId, placeId : String
    var seen, isStudy, isRv : Bool
    var placements, tagIds: NSMutableArray
    var priority: Person.Priority
    
    init(visitId : String, personId : String, placeId : String) {
        
        self.visitId = visitId
        self.personId = personId
        self.placeId = placeId
        
        self.seen = true
        self.isStudy = false
        self.isRv   = false
        
        self.priority = .NONE
        
        self.placements = NSMutableArray()
        self.tagIds = NSMutableArray()
        
        super.init(idHeader: VisitDetail.VISIT_DETAIL)
    }
    
    init(lastVisitDetail: VisitDetail) {
        
        self.visitId = lastVisitDetail.visitId
        self.personId = lastVisitDetail.personId
        self.placeId = lastVisitDetail.placeId
        
        self.seen = false
        self.isStudy = lastVisitDetail.isStudy
        self.isRv   = lastVisitDetail.isRv
        
        self.priority = lastVisitDetail.priority
        
        self.placements = NSMutableArray()
        self.tagIds = NSMutableArray(array: lastVisitDetail.tagIds)
        
        super.init(idHeader: VisitDetail.VISIT_DETAIL)

    }
    
    func description(indent: Int, withTag : Bool) -> String {
        var indentSpace = ""
        for _ in 0  ..< indent  {
            indentSpace = indentSpace + " "
        }
        
        
    }
    
    
    
}
