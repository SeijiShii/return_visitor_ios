//
//  Publication.swift
//  ReturnVisitor
//
//  Created by Seiji Shii on 2017/07/04.
//  Copyright © 2017年 SeijiShii. All rights reserved.
//

import Foundation
class Publication: DataItem {
    
    enum Category : String {
        
        case BIBLE      = "Bible"
        case BOOK       = "Book"
        case TRACT      = "Tract"
        case MAGAZINE   = "Magazine"
        case WEB_LINK   = "Web Link"
        case SHOW_VIDEO = "Video Showing"
        case OTHER      = "Other"
    }
    
    enum MagazinCategory : String {
        case WATCHTOWER         = "WATCHTOWER"
        case STUDY_WATCHTOWER   = "Study WATCHTOWER"
        case AWAKE              = "Awake!"
    }
    
    let publicationCategoryArray = [
        "Bible",
        "Book",
        "Tract",
        "Magazine",
        "Web Link",
        "Video Showing",
        "Other"
    ]
    
    let magazineCategoryArray = [
        "WATCHTOWER",
        "Study WATCHTOWER",
        "Awake!"
    ]
    
    static let PUBLICATION : String = "publication"
    
    var category: Category
    var magazineCategory: MagazinCategory?
    var number: Date
    var weight: Int?
    
    init(category: Category) {
        self.category = category
        self.number = Date()
        
        super.init(idHeader: Publication.PUBLICATION)
    }
    
    func description() -> String {
        
        var string: String
        if (category != .MAGAZINE) {
            string = category.rawValue
        } else {
            string = (magazineCategory?.rawValue)! + " " + getNumberString()!
        }
        if name.utf8.count > 0 {
            string = string + " " + name
        }
        return string
        
    }
    
    func getNumberString() -> String? {
        
        if category != .MAGAZINE {
            return nil
        }
        
        let dateFormatter = DateFormatter()
        
        if magazineCategory == MagazinCategory.STUDY_WATCHTOWER {
            
            dateFormatter.dateFormat = "yyyy MMM"
            
            return dateFormatter.string(from: number)
            
        } else {
            
            dateFormatter.dateFormat = "yyyy "
            let yearString = dateFormatter.string(from: number)
            
            let calendar = Calendar(identifier: .gregorian)
            let month = calendar.component(.month, from: number)
            
            return yearString + String((month + 1) / 2)
            
        }
    }
}
