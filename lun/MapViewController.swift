//
//  MapViewController.swift
//  lun
//
//  Created by Alyona Hulak on 2/20/19.
//  Copyright © 2019 Alyona Hulak. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {

    var name = ""
    var lat: Double = 50.45466
    var lng: Double = 30.5238
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        
        let camera = GMSCameraPosition.camera(withLatitude: self.lat, longitude: self.lng, zoom: 15.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.setMinZoom(10, maxZoom: 100)
        view = mapView
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: self.lat, longitude: self.lng)
        marker.title = self.name
        marker.map = mapView
    }

}
