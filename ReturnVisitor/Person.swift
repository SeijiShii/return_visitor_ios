//
//  Person.swift
//  ReturnVisitor
//
//  Created by Seiji Shii on 2017/07/04.
//  Copyright © 2017年 SeijiShii. All rights reserved.
//

import Foundation
class Person: DataItem {
    
    enum Sex : String{
        case SEX_UNKNOWN = "Unknown"
        case MALE = "Male"
        case FEMALE = "Female"
    }
    
    enum Age : String {
        case AGE_UNKNOWN    = "Unknown"
        case AGE__10        = "〜10"
        case AGE_11_20      = "11〜20"
        case AGE_21_30      = "21〜30"
        case AGE_31_40      = "31〜40"
        case AGE_41_50      = "41〜50"
        case AGE_51_60      = "51〜60"
        case AGE_61_70      = "61〜70"
        case AGE_71_80      = "71〜80"
        case AGE_80_        = "81〜"
    }
    
    enum Priority : String {
        case NONE       = "None"
        case NEGATIVE   = "Negative"
        case FOR_NEXT   = "For next covering"
        case NOT_HOME   = "Not home"
        case BUSY       = "Busy (must call again)"
        case LOW        = "Low"
        case MIDDLE     = "Middle"
        case HIGH       = "High"
    }
    
    static let PERSON = "person"
    
    var sex: Sex
    var age: Age
    var priority : Priority
    var placeId: String
    
    init(placeId: String) {
        self.placeId = placeId
        self.age = .AGE_UNKNOWN
        self.sex = .SEX_UNKNOWN
        self.priority = .NONE
        
        super.init(idHeader: Person.PERSON)
    }
}
