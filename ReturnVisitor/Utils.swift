//
//  Utils.swift
//  ReturnVisitor
//
//  Created by Seiji Shii on 2017/06/05.
//  Copyright © 2017年 SeijiShii. All rights reserved.
//

import Foundation

import UIKit

struct DeviceSize {
    
    //CGRectを取得
    static func bounds() ->CGRect {
        return UIScreen.main
            .bounds
    }
    
    //画面の横サイズを取得
    static func screenWidth() ->Int {
        return Int(UIScreen.main.bounds.size.width)
    }
    
    //画面の縦サイズを取得
    static func screenHeight() ->Int {
        return Int(UIScreen.main.bounds.size.height)
    }
    
    static func statusBarHeight() -> CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    static func navBarHeight(navigationController: UINavigationController) -> CGFloat {
        return navigationController.navigationBar.frame.size.height
    }
    
    static func tabBarHeight(tabBarController: UITabBarController) -> CGFloat {
        return tabBarController.tabBar.frame.size.height
    }
    
}

struct UserDefaultKeys {
    struct CameraPosition {
        static let latitude: String = "latitude"
        static let longitude: String = "longitude"
        static let zoomLevel: String = "zoom_level"
    }
}

struct AdViewSize {
    static let height: CGFloat = 50
}

class DeviceHorizontalness {
    static func isHorizontalRegular(viewController: UIViewController) -> Bool {
        // .Regularか.Compactか
        let collection = UITraitCollection(horizontalSizeClass: .regular)
        // 含有しているか判定
        return viewController.traitCollection.containsTraits(in: collection)
    }
}
