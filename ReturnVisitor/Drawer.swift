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

    var delegate : DrawerDelegate?
    
    let drawerWidth: Int = 300
    var overlay: UIView!
    var drawerView: UIView!
    
    var isDrawerOpen : Bool
    
    override init(frame: CGRect) {
        
        isDrawerOpen = false

        super.init(frame: frame)
        
        initOverlay()
        initDrawerView()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initOverlay() {
        overlay = UIView(frame: self.frame)
        overlay.backgroundColor = UIColor.darkGray
        overlay.alpha = 0
        self.addSubview(overlay)
    }
    
    func initDrawerView() {
        drawerView = UIView(frame: CGRect(x: -drawerWidth, y: 0, width: drawerWidth, height: Int(self.frame.height)))
        drawerView.backgroundColor = UIColor.white
        self.addSubview(drawerView)
    }
    
    func openDrawer() {
        
    }
    
    func openCloseDrawer()  {
        
        var target: CGFloat
        
        if isDrawerOpen {
            target = -(CGFloat)(drawerWidth)
        } else {
            target = 0
        }
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.drawerView.frame.origin.x = target
        }, completion: {(Bool) -> Void in
            
            self.isDrawerOpen = !self.isDrawerOpen})
    }
    
}

protocol DrawerDelegate {
    func postCloseDrawer()
}
