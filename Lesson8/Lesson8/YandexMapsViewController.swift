//
//  ViewController.swift
//  Lesson8
//
//  Created by Дарья Никитина on 04.06.2024.
//

import UIKit
import YandexMapsMobile
import CoreLocation

class YandexMapsViewController: UIViewController,
                                CLLocationManagerDelegate,
                                YMKUserLocationObjectListener {
    let locationManager = CLLocationManager()
    
    lazy var map: YMKMap? = {
        return mapView.mapWindow.map
    }()
    let mapView: YMKMapView = YMKMapView(frame: .zero)
    
    var currentLocation: YMKPoint?
    var accuracyCircle: YMKCircleMapObject?
    var userLocationLayer: YMKUserLocationLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.frame = view.bounds
        view.addSubview(mapView)
        
        let locationPoint: YMKPoint
        if let currentLocation {
            locationPoint = currentLocation
        } else {
            locationPoint = YMKPoint(latitude: 55.751574, longitude: 37.573856)
        }
        let cameraPosition = YMKCameraPosition(target: locationPoint, zoom: 11.0, azimuth: 0.0, tilt: 0.0)
        mapView.mapWindow.map.move(with: cameraPosition)
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        userLocationLayer = YMKMapKit.sharedInstance().createUserLocationLayer(with: mapView.mapWindow)
        userLocationLayer?.isHeadingEnabled = true
        userLocationLayer?.setObjectListenerWith(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        YMKMapKit.sharedInstance().onStart()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        YMKMapKit.sharedInstance().onStop()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let coordinate = location.coordinate
        let point = YMKPoint(latitude: coordinate.latitude, longitude: coordinate.longitude)
        currentLocation = point
        let cameraPosition = YMKCameraPosition(target: point, zoom: 15.0, azimuth: 0.0, tilt: 0.0)
        mapView.mapWindow.map.move(with: cameraPosition,
                                   animation: YMKAnimation(type: YMKAnimationType.smooth, duration: 0.5))
        let accuracy = location.horizontalAccuracy
        updateAccuracyCircle(coordinate: coordinate, radius: accuracy)
    }
    
    private func updateAccuracyCircle(coordinate: CLLocationCoordinate2D, radius: CLLocationDistance) {
        let circle = YMKCircle(center: YMKPoint(latitude: coordinate.latitude, longitude: coordinate.longitude),
                               radius: Float(radius))
        
        if accuracyCircle != nil {
            accuracyCircle?.geometry = circle
        } else {
            accuracyCircle = map?.mapObjects.addCircle(with: circle)
        }
    }
    
    func onObjectAdded(with view: YMKUserLocationView) {
        let pinImage = UIImage(systemName: "circle")!
        view.pin.setIconWith(pinImage)
        
        let accuracy = view.accuracyCircle
        let center = YMKPoint(
            latitude: accuracy.geometry.center.latitude,
            longitude: accuracy.geometry.center.longitude)
        let circle = YMKCircle(center: center, radius: accuracy.geometry.radius)
        mapView.mapWindow.map.mapObjects.addCircle(with: circle)
    }
    
    func onObjectRemoved(with view: YMKUserLocationView) {
        
    }
    
    func onObjectUpdated(with view: YMKUserLocationView, event: YMKObjectEvent) {
        
    }
}
