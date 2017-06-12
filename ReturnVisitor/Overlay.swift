//
//  Overlay.swift
//  ReturnVisitor
//
//  Created by Seiji Shii on 2017/06/12.
//  Copyright © 2017年 SeijiShii. All rights reserved.
//

import Foundation
import UIKit
class Overlay: UIView {
    
//    var isShowing: Bool = false
    var showingWidth: CGFloat!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.showingWidth = frame.width
        self.frame.size.width = 0
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.alpha = 0
        
        let tapOverlayGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapOverlay(_:)))
        self.addGestureRecognizer(tapOverlayGesture)
        //            self.isUserInteractionEnabled = true
        
    }
    
    required init (coder: NSCoder) {
        super.init(coder: coder)!
    }
    
    func fadeOverlay(fadeIn : Bool) {
        if (fadeIn) {
            self.frame.size.width = showingWidth
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
                self.alpha = 1
            }, completion: nil)
            
            
        } else {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
                self.alpha = 0
            }, completion: { (Bool) in
                self.frame.size.width = 0
            })
        }
    }
    
    func tapOverlay(_ sender : UITapGestureRecognizer) {
        print("Overlay tapped!")
        fadeOverlay(fadeIn: false)
    }
    
}
