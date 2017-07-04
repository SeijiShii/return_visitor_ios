//
//  Placement.swift
//  ReturnVisitor
//
//  Created by Seiji Shii on 2017/07/04.
//  Copyright © 2017年 SeijiShii. All rights reserved.
//

import Foundation
class Placement {
    
    var publicationId: String
    var publicationData : String
    var category : Publication.Category
    
    init(publication : Publication) {
        self.publicationId = publication.id
        self.publicationData = publication.description()
        self.category = publication.category
    }
}
