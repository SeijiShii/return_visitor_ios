//
//  RecordVisitViewController.swift
//  ReturnVisitor
//
//  Created by Seiji Shii on 2017/06/13.
//  Copyright © 2017年 SeijiShii. All rights reserved.
//

import Foundation
import UIKit
class RecordVisitViewController: UIViewController {
    
    var visit : Visit
    
    init(visit: Visit) {
    
        self.visit = visit
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    var primaryPane, secondaryPane: UIView!
    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor.white
        
        self.primaryPane = UIView()
        self.secondaryPane = UIView()
        
        self.view.addSubview(primaryPane)
        self.view.addSubview(secondaryPane)
    }
    
    
}
