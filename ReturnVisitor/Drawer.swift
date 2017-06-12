//
//  Drawer.swift
//  ReturnVisitor
//
//  Created by Seiji Shii on 2017/06/10.
//  Copyright © 2017年 SeijiShii. All rights reserved.
//

import Foundation
import UIKit

class Drawer: UIView {

    var delegate: DrawerDelegate?
    
    let defaultWidth : Int = 300
    var drawerWidth: Int!
    
    var isDrawerOpen : Bool
    
    override init(frame: CGRect) {
        
        isDrawerOpen = false

        super.init(frame: frame)
        
        drawerWidth = defaultWidth
        if Int(frame.width) < defaultWidth {
            drawerWidth = Int(frame.width) - 40
        }
        
        self.frame = CGRect(x: -drawerWidth, y: 0, width: drawerWidth, height: Int(self.frame.height))
        self.backgroundColor = UIColor.white
        
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeToLeft(_:)))
        leftSwipeGesture.direction = .left
        self.addGestureRecognizer(leftSwipeGesture)
        
    }
    
    func updateHeight(height: Int) {
        self.frame.size.height = CGFloat(height)
    }
    
    func swipeToLeft(_ sender: UIPanGestureRecognizer) {
        closeDrawer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func openDrawer() {
        if isDrawerOpen {
            return
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.frame.origin.x = 0
        }, completion: {(Bool) -> Void in
            self.isDrawerOpen = true
        })

    }
    
    func closeDrawer() {
        if !isDrawerOpen {
            return
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.frame.origin.x = CGFloat(-self.drawerWidth)
        }, completion: {(Bool) -> Void in
            self.isDrawerOpen = false
            self.delegate?.onCloseDrawer()
        })
    }
}

protocol DrawerDelegate {
    func onCloseDrawer()
}

