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
    
    var showingWidth: CGFloat!
    var delegate: OverlayDelegate?
    var isShowing: Bool
    
    override init(frame: CGRect) {
        
        isShowing = false
        
        super.init(frame: frame)
        
        self.showingWidth = frame.width
        self.frame.size.width = 0
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.alpha = 0
        
        let tapOverlayGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapOverlay(_:)))
        self.addGestureRecognizer(tapOverlayGesture)
        //            self.isUserInteractionEnabled = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateSize(size: CGSize) {
        
        self.showingWidth = CGFloat(size.width)
        self.frame.size.height = CGFloat(size.height)
        
        if (isShowing) {
            self.frame.size.width = showingWidth
        }
    }
    
    func fadeOverlay(fadeIn : Bool) {
        
        if fadeIn {
            
            if isShowing {
                return
            }
            
            self.frame.size.width = showingWidth
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
                self.alpha = 1
            }, completion: { (Bool) in
                self.isShowing = true
            })
            
            
        } else {
            if !isShowing {
                return
            }
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
                self.alpha = 0
            }, completion: { (Bool) in
                self.frame.size.width = 0
                self.isShowing = false
            })
        }
    }
    
    func tapOverlay(_ sender : UITapGestureRecognizer) {
        print("Overlay tapped!")
        fadeOverlay(fadeIn: false)
        self.delegate?.onTapOverlay()
    }
    
}

protocol OverlayDelegate {
    
    func onTapOverlay()
}
