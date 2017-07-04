//
//  PlaceMarkers.swift
//  ReturnVisitor
//
//  class PlaceMarker
//      Mapに追加したマーカーを場所IDと共に保存し、管理するオブジェクト
//
//  class PlaceMarkers
//      PlaceMarkerのリスト
//
//  Created by Seiji Shii on 2017/07/04.
//  Copyright © 2017年 SeijiShii. All rights reserved.
//

import Foundation
import GoogleMaps

class PlaceMarker {
    
    var marker: GMSMarker
    var placeId: String
    
    init(placeId: String, marker: GMSMarker) {
        self.placeId = placeId
        self.marker = marker
    }
    
}

class PlaceMarkers {
    
    var markers: NSMutableArray
    var mapView: GMSMapView
    
    init(mapView: GMSMapView) {
        
        self.mapView = mapView
        self.markers = NSMutableArray()
    }
    
    private func addMarker(place: Place) {
        
    }

}

