//
//  Tag.swift
//  ReturnVisitor
//
//  Created by Seiji Shii on 2017/07/04.
//  Copyright © 2017年 SeijiShii. All rights reserved.
//

import Foundation
class Tag: DataItem {
    
    static let TAG = "tag"
    
    init(name: String) {
        super.init(idHeader: Tag.TAG)
        self.name = name
    }
}
