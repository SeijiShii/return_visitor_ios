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

class MapViewController: UIViewController, GMSMapViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initMapView()
        initZoomButton()
        
        initAdView()
        
    }

    var mapView: GMSMapView!
    func initMapView() {
        // Create a GMSCameraPosition that tells the map to display the
        let mapFrame: CGRect = CGRect(x: 0, y: 0, width: DeviceSize.screenWidth(), height: DeviceSize.screenHeight() - 50)
        var cameraPosition = loadCameraPosition();
        if cameraPosition == nil {
            cameraPosition = GMSCameraPosition.camera(withLatitude: 0, longitude: 0, zoom: 1.0)
        }
        mapView = GMSMapView.map(withFrame: mapFrame, camera: cameraPosition!)
        mapView.isMyLocationEnabled = true
        
        mapView.mapType = GMSMapViewType.hybrid
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        
        mapView.settings.rotateGestures = true
        mapView.settings.zoomGestures = true
        
        mapView.delegate = self
        
        view.addSubview(mapView)
        
        // Creates a marker in the center of the map.
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
//        marker.map = mapView
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        saveCameraPosition();
    }
    
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        return true
    }

    func saveCameraPosition() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(mapView.camera.target.latitude, forKey: UserDefaultKeys.CameraPosition.latitude)
        userDefaults.set(mapView.camera.target.longitude, forKey: UserDefaultKeys.CameraPosition.longitude)
        userDefaults.set(mapView.camera.zoom, forKey: UserDefaultKeys.CameraPosition.zoomLevel)
        userDefaults.synchronize()
    }
    
    func loadCameraPosition() -> GMSCameraPosition? {
        let userDefaults = UserDefaults.standard
        let lat: CLLocationDegrees? = CLLocationDegrees(userDefaults.double(forKey: UserDefaultKeys.CameraPosition.latitude))
        let lng: CLLocationDegrees? = CLLocationDegrees(userDefaults.double(forKey: UserDefaultKeys.CameraPosition.longitude))
        let zoom : Float? = userDefaults.float(forKey: UserDefaultKeys.CameraPosition.zoomLevel)
        if lat != nil && lng != nil && zoom != nil {
            return GMSCameraPosition.camera(withLatitude: lat!, longitude: lng!, zoom: zoom!)
        } else {
            return nil
        }
    }
    
    func initZoomButton() {
        let zoomButton : UIStepper = UIStepper()
        zoomButton.frame.origin.x = mapView.frame.width / 2 - zoomButton.frame.width / 2
        zoomButton.frame.origin.y = mapView.frame.height - (zoomButton.frame.height + 10)
        mapView.addSubview(zoomButton)
        
        zoomButton.minimumValue = Double(mapView.minZoom)
        zoomButton.maximumValue = Double(mapView.maxZoom)
        zoomButton.value = Double(mapView.camera.zoom)
        zoomButton.addTarget(self, action: #selector(MapViewController.zoomMap(sender:)), for: .touchUpInside)
    }
    
    func zoomMap(sender: UIStepper) {
        mapView.animate(toZoom: Float(sender.value))
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
