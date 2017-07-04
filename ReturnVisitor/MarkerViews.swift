//
//  MarkerViews.swift
//  ReturnVisitor
//
//  Created by Seiji Shii on 2017/07/04.
//  Copyright © 2017年 SeijiShii. All rights reserved.
//

import Foundation
import UIKit

class PinMarkerView: UIImageView {
    
    
    init(named : String) {
        super.init(frame: CGRect(x: 0, y: 0, width: 25, height: 40))
        self.image = UIImage(named: named)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

struct MarkerViews {
    struct PinMarkers {
        static let gray    = PinMarkerView(named: "pin_marker_gray.png")
        static let red     = PinMarkerView(named: "pin_marker_red.png")
        static let purple  = PinMarkerView(named: "pin_marker_purple.png")
        static let blue    = PinMarkerView(named: "pin_marker_blue.png")
        static let green   = PinMarkerView(named: "pin_marker_green.png")
        static let emerald = PinMarkerView(named: "pin_marker_emerald.png")
        static let yellow  = PinMarkerView(named: "pin_marker_yellow.png")
        static let orange  = PinMarkerView(named: "pin_marker_orange.png")
    }
}
