//
//  DataItem.swift
//  ReturnVisitor
//
//  Created by Seiji Shii on 2017/07/04.
//  Copyright © 2017年 SeijiShii. All rights reserved.
//

import Foundation

class DataItem {
    
    var id: String
    var name: String
    var note: String

    init()  {
        self.id = ""
        self.name = ""
        self.note = ""
    }
    
    init(idHeader: String) {
        
        self.init()
        self.id = generateId(idHeader: idHeader)
    }
    
    
    func generateId(idHeader: String) -> String {
        
        let milSecString: String = String((Date().timeIntervalSince1970 * 1000.0).rounded())
        let rndNumString: String = String(format: "%04d", arc4random() % 10000)
        return idHeader + "_" + milSecString + rndNumString
    }
        
}

func ==(lhs: DataItem, rhs: DataItem) -> Bool {
    return lhs.id == rhs.id
}
