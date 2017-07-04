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
    
    var isHorizontalRegular: Bool! = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setIsHorizontalRegular()
        
        initMapBaseView()
        
        initLeftColumn()
        
        initAdView()
        
    }
    
    var leftColumnWidth : CGFloat! = 240
    
    override func viewWillTransition(to size: CGSize, with coordinator:UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        setIsHorizontalRegular()
        updateViewSizes(screenSize: size)
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setIsHorizontalRegular()
        updateViewSizes(screenSize: DeviceSize.bounds().size)
    }
  
    func updateViewSizes(screenSize : CGSize) {
        updateMapBaseViewSize(screenSize: screenSize)
        updateMapViewFrame()
        updateZoomButtonFrame()
        updateMapLabel()
        updateOverlaySize()
        updateLeftColumFrame(screenSize: screenSize)
        
        refreshLogoButton()
        refreshColumnLogoButton()
        
        updateAdFrame(screenSize : screenSize)
    }
    
    var mapBaseView: UIView!
    func initMapBaseView() {
        mapBaseView = UIView()
        updateMapBaseViewSize(screenSize: DeviceSize.bounds().size)
        self.view.addSubview(mapBaseView)
        
        initMapView()
        initOverlay()
        initLogoButton()
    }
    
    func updateMapBaseViewSize(screenSize: CGSize) {
        mapBaseView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height - AdViewSize.height)
        if isHorizontalRegular! {
            mapBaseView.frame.origin.x = leftColumnWidth
            mapBaseView.frame.size.width = screenSize.width - leftColumnWidth
        }
    }
    
    
    var leftColumn : UIView!
    var leftSwipe: UISwipeGestureRecognizer!
    func initLeftColumn() {
        leftColumn = UIView()
        leftColumn.backgroundColor = UIColor.white
        
        leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeftColumn(_:)))
        leftSwipe.direction = .left
        
        updateLeftColumFrame(screenSize: DeviceSize.bounds().size)
        self.view.addSubview(leftColumn)
        
        initColumnLogoButton()
        initAppTitle()
    }
    
    
    func updateLeftColumFrame(screenSize: CGSize) {
        
        leftColumn.frame = CGRect(x: -leftColumnWidth, y: 0, width: leftColumnWidth, height: screenSize.height - AdViewSize.height)
        
        if isHorizontalRegular! {
            leftColumn.removeGestureRecognizer(leftSwipe)
            leftColumn.frame.origin.x = 0
        } else {
            leftColumn.addGestureRecognizer(leftSwipe)
        }
    }
    
    func swipeLeftColumn(_ sender : UISwipeGestureRecognizer) {
        closeLeftColumn()
    }
    
    func closeLeftColumn() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.leftColumn.frame.origin.x = -self.leftColumnWidth
            self.overlay.alpha = 0
            self.logoButton.alpha = 1
        }, completion: nil)
    }

    func openLeftColumn() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.leftColumn.frame.origin.x = 0
            self.overlay.alpha = 1
            self.logoButton.alpha = 0
        }, completion: nil)
    }
    

    var mapView: GMSMapView!
    func initMapView() {
        // Create a GMSCameraPosition that tells the map to display the
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
        mapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        
        mapView.delegate = self
        
        self.mapBaseView.addSubview(mapView)
        
        initZoomButton()
        initMapLabel()
        
    }
    
    func updateMapViewFrame() {
        mapView.frame = CGRect(x: 0, y: 0, width: mapBaseView.frame.width, height: mapBaseView.frame.height)
    }
    
    func setIsHorizontalRegular() {
        // .Regularか.Compactか
        let collection = UITraitCollection(horizontalSizeClass: .regular)
        // 含有しているか判定
        isHorizontalRegular = traitCollection.containsTraits(in: collection)

    }
        
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        saveCameraPosition();
        zoomButton.value = Double(mapView.camera.zoom)
    }
    
    var provisionalMarker: GMSMarker?
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        mapView.animate(toLocation: coordinate)
        showLongPressDialog(coordinate: coordinate)
        // 仮マーカーの表示
        
        let marker = GMSMarker()
        marker.position = coordinate
        marker.iconView = MarkerViews.PinMarkers.gray
        marker.map = mapView
        
        provisionalMarker = marker
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
        zoomButton.frame = CGRect(x: mapView.frame.width / 2 - zoomButton.frame.width / 2, y: mapView.frame.height - (zoomButton.frame.height + 25), width:
            zoomButton.frame.width, height: zoomButton.frame.height)
    }
    
    func zoomMap(sender: UIStepper) {
        mapView.animate(toZoom: Float(sender.value))
    }
    
    var mapLabel: UILabel!
    func initMapLabel() {
        mapLabel = UILabel()
        mapLabel.frame.size.height = 20
        mapLabel.text = "Tap marker or Long press on the map."
        mapLabel.font = UIFont.systemFont(ofSize: 15)
        mapLabel.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        mapLabel.textColor = UIColor.white
        mapLabel.textAlignment = NSTextAlignment.center
        updateMapLabel()
        mapView.addSubview(mapLabel)
    }
    
    func updateMapLabel() {
        mapLabel.frame.size.width = mapView.frame.width
        mapLabel.frame.origin = CGPoint(x: 0, y: mapView.frame.height - mapLabel.frame.height)
    }
    
    
    var adView : UIView!
    func initAdView() {

        adView = UIView()

        updateAdFrame(screenSize : DeviceSize.bounds().size)
        adView.backgroundColor = UIColor.gray
        view.addSubview(adView)
    }
    
    func updateAdFrame(screenSize: CGSize) {
        adView.frame = CGRect(x: 0, y: screenSize.height - AdViewSize.height, width: screenSize.width, height: AdViewSize.height)
    }
    
    var logoButton: UIButton!
    func initLogoButton() {
        logoButton = UIButton(frame: CGRect(x: 20, y: 30, width: 40, height: 40))
        let logo = UIImage(named: "logo_80.png")
        logoButton.setImage(logo, for: .normal)
        self.mapBaseView.addSubview(logoButton)
        
        logoButton.addTarget(self, action: #selector(tapLogoButton(_:)), for: .touchUpInside)
    }
    
    func refreshLogoButton() {
        if isHorizontalRegular! {
            logoButton.alpha = 0
        } else {
            logoButton.alpha = 1
        }
    }
    
    func tapLogoButton(_ sender: UIButton) {
        print("Logo tapped!")
        openLeftColumn()
    }
    
    var overlay: UIView!
    var tapOverlayGesture: UITapGestureRecognizer!
    func initOverlay() {
        overlay = UIView()
        if #available(iOS 10.0, *) {
            overlay.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.5)
        } else {
            // Fallback on earlier versions
            overlay.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        }
        overlay.alpha = 0
        
        tapOverlayGesture = UITapGestureRecognizer(target: self, action: #selector(tapOverlay(_:)))
        updateOverlaySize()
        self.mapBaseView.addSubview(overlay)
    }
    
    func updateOverlaySize() {
        overlay.frame = CGRect(x: 0, y: 0, width: mapBaseView.frame.width, height: mapBaseView.frame.height)
        
        if isHorizontalRegular! {
            overlay.removeGestureRecognizer(tapOverlayGesture)
            
            if overlay.alpha == 1.0 {
                UIView.animate(withDuration: 0.5, animations: { 
                    self.overlay.alpha = 0
                })
            }
            
        } else {
            overlay.addGestureRecognizer(tapOverlayGesture)
        }
    }
    
    func tapOverlay(_ sender: UITapGestureRecognizer) {
        closeLeftColumn()
    }
    
    var columnLogoButton: UIButton!
    func initColumnLogoButton() {
        columnLogoButton = UIButton()
        columnLogoButton.setImage(UIImage(named: "logo_80.png"), for: .normal)
        columnLogoButton.frame.size = CGSize(width: 40, height: 40)
        columnLogoButton.frame.origin = CGPoint(x: leftColumn.frame.width / 2 - columnLogoButton.frame.width / 2, y: 30)
        leftColumn.addSubview(columnLogoButton)
        refreshColumnLogoButton()
    
    }
    
    func refreshColumnLogoButton() {
        if isHorizontalRegular! {
            columnLogoButton.isUserInteractionEnabled = false
            columnLogoButton.removeTarget(self, action: #selector(tapColumnLogoButton(_:)), for: .touchUpInside)
        } else {
            columnLogoButton.isUserInteractionEnabled = true
            columnLogoButton.addTarget(self, action: #selector(tapColumnLogoButton(_:)), for: .touchUpInside)
        }
    }
    
    func tapColumnLogoButton(_ sender: UIButton) {
        closeLeftColumn()
    }
    
    func initAppTitle() {
        let titleLabel = UILabel()
        titleLabel.text = "Return Visitor"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.sizeToFit()
        titleLabel.frame.origin = CGPoint(x: leftColumn.frame.width / 2 - titleLabel.frame.width / 2, y: 80)
        leftColumn.addSubview(titleLabel)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var longPressDialog : UIAlertController!
    func showLongPressDialog(coordinate: CLLocationCoordinate2D) {
        longPressDialog = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        longPressDialog.addAction(UIAlertAction(title: "Record Single House", style: .default, handler: { (UIAlertAction) in
            print("Record Single House tapped!")
            
        }))
        longPressDialog.addAction(UIAlertAction(title: "Record Housing Complex", style: .default, handler: { (UIAlertAction) in
            
        }))
        longPressDialog.addAction(UIAlertAction(title: "Record as Not Home", style: .default, handler: { (UIAlertAction) in
            
        }))
        longPressDialog.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(UIAlertAction) in
            print("longPressDialog dismissed!")
            self.provisionalMarker!.map = nil

        }))
        longPressDialog.popoverPresentationController?.sourceView = mapView
        longPressDialog.popoverPresentationController?.sourceRect = CGRect(x: mapView.frame.width / 2, y: mapView.frame.height / 2, width: 0, height: 0)
        
        self.present(longPressDialog, animated: true, completion: nil)
    }
    
    
}
