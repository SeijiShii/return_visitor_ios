//
//  MapViewController.swift
//  ReturnVisitor
//
//  Created by Seiji Shii on 2017/06/05.
//  Copyright © 2017年 SeijiShii. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initMapView()
        initZoomButton()
        
        initAdView()
        
    }

    var mapView: GMSMapView!
    func initMapView() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapFrame: CGRect = CGRect(x: 0, y: 0, width: DeviceSize.screenWidth(), height: DeviceSize.screenHeight() - 50)
        mapView = GMSMapView.map(withFrame: mapFrame, camera: camera)
        mapView.isMyLocationEnabled = true
        
        mapView.mapType = GMSMapViewType.hybrid
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        
        mapView.settings.rotateGestures = true
        mapView.settings.zoomGestures = true
        
        
        view.addSubview(mapView)
        
        // Creates a marker in the center of the map.
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
//        marker.map = mapView
    }
    
    func initZoomButton() {
        let zoomButton : UIStepper = UIStepper()
        zoomButton.frame.origin.x = mapView.frame.width / 2 - zoomButton.frame.width / 2
        zoomButton.frame.origin.y = mapView.frame.height - (zoomButton.frame.height + 10)
        mapView.addSubview(zoomButton)
    }
    
    func initAdView() {

        let grayRect : UIView = UIView(frame: CGRect(x: 0, y: DeviceSize.screenHeight() - 50, width: DeviceSize.screenWidth(), height: 50))
        grayRect.backgroundColor = UIColor.gray
        view.addSubview(grayRect)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
