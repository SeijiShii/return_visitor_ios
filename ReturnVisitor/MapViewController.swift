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
    var mapFrame: CGRect!
    func initMapView() {
        // Create a GMSCameraPosition that tells the map to display the
        mapFrame = CGRect(x: 0, y: 0, width: DeviceSize.screenWidth(), height: DeviceSize.screenHeight() - 50)
        var cameraPosition = loadCameraPosition();
        if cameraPosition == nil {
            cameraPosition = GMSCameraPosition.camera(withLatitude: 0, longitude: 0, zoom: 1.0)
        }
        mapView = GMSMapView()
        mapView.camera = cameraPosition!
        updateMapViewFrame()
        mapView.isMyLocationEnabled = true
        
        mapView.mapType = GMSMapViewType.hybrid
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        
        mapView.settings.rotateGestures = true
        mapView.settings.zoomGestures = true
        
        mapView.delegate = self
        
        view.addSubview(mapView)
        
    }
    
    func updateMapViewFrame() {
        mapFrame = CGRect(x: 0, y: 0, width: DeviceSize.screenWidth(), height: DeviceSize.screenHeight() - 50)
        mapView.frame = mapFrame
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {

        updateMapViewFrame()
        updateZoomButtonFrame()
        updateAdFrame()
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
    
    var zoomButton : UIStepper!
    var zoomButtonFrame: CGRect!
    func initZoomButton() {
        zoomButton = UIStepper()
        
        updateZoomButtonFrame()
        
        mapView.addSubview(zoomButton)
        
        zoomButton.minimumValue = Double(mapView.minZoom)
        zoomButton.maximumValue = Double(mapView.maxZoom)
        zoomButton.value = Double(mapView.camera.zoom)
        zoomButton.addTarget(self, action: #selector(MapViewController.zoomMap(sender:)), for: .touchUpInside)
    }
    
    func updateZoomButtonFrame() {
        zoomButtonFrame = CGRect(x: mapView.frame.width / 2 - zoomButton.frame.width / 2, y: mapView.frame.height - (zoomButton.frame.height + 10), width:
            zoomButton.frame.width, height: zoomButton.frame.height)
        zoomButton.frame = zoomButtonFrame
    }
    
    func zoomMap(sender: UIStepper) {
        mapView.animate(toZoom: Float(sender.value))
    }
    
    
    var adView : UIView!
    var adFrame : CGRect!
    
    func initAdView() {

        adView = UIView()

        updateAdFrame()
        adView.backgroundColor = UIColor.gray
        view.addSubview(adView)
    }
    
    func updateAdFrame() {
        adFrame = CGRect(x: 0, y: DeviceSize.screenHeight() - 50, width: DeviceSize.screenWidth(), height: 50)
        adView.frame = adFrame
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
