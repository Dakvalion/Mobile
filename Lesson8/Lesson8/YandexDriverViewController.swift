//
//  YandexDriverViewController.swift
//  Lesson8
//
//  Created by Дарья Никитина on 04.06.2024.
//

import UIKit
import YandexMapsMobile
import CoreLocation

class YandexDriverViewController: UIViewController,
                                  CLLocationManagerDelegate,
                                  YMKMapObjectTapListener {
    
    let locationManager = CLLocationManager()
    
    lazy var map: YMKMap? = {
        return mapView.mapWindow.map
    }()
    let mapView: YMKMapView = YMKMapView(frame: .zero)
    var currentLocation: YMKPoint = YMKPoint(latitude: 55.648413, longitude: 37.386759)
    let kremlinLocation: YMKPoint = YMKPoint(latitude: 55.751435, longitude: 37.618816)
    var drivingSession: YMKDrivingSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.frame = view.bounds
        view.addSubview(mapView)
        
        let cameraPosition = YMKCameraPosition(target: currentLocation, zoom: 15.0, azimuth: 0.0, tilt: 0.0)
        mapView.mapWindow.map.move(with: cameraPosition,
                                   animation: YMKAnimation(type: YMKAnimationType.smooth, duration: 0.5))
        
        locationManager.delegate = self
        if locationManager.authorizationStatus != .authorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        } else {
            locationManager.startUpdatingLocation()
        }
    }
    
    func submitRequest() {
        let drivingOptions = YMKDrivingOptions()
        drivingOptions.routesCount = 2
        let requestPoints : [YMKRequestPoint] = [
            YMKRequestPoint(point: YMKPoint(latitude: currentLocation.latitude,
                                            longitude: currentLocation.longitude),
                            type: .waypoint,
                            pointContext: nil,
                            drivingArrivalPointId: nil),
            YMKRequestPoint(point: kremlinLocation,
                            type: .waypoint,
                            pointContext: nil,
                            drivingArrivalPointId: nil)
        ]
        let drivingRouter = YMKDirectionsFactory.instance().createDrivingRouter(withType: .combined)
        drivingSession = drivingRouter.requestRoutes(
            with: requestPoints,
            drivingOptions: drivingOptions,
            vehicleOptions: YMKDrivingVehicleOptions(),
            routeHandler: drivingRouteHandler
        )
    }
    
    func drivingRouteHandler(drivingRoutes: [YMKDrivingRoute]?, error: Error?) {
        if let error {
            showToast(title: "Маршрут не построен :(", message: error.localizedDescription)
            return
        }
        guard let drivingRoutes else { return }
        let drivingColors: [UIColor] = [.red, .green]
        for (index, route) in drivingRoutes.enumerated() {
            map?.mapObjects.addPolyline(with: route.geometry).setStrokeColorWith(drivingColors[index % 2])
        }
        
        let placemark = map?.mapObjects.addPlacemark()
        placemark?.geometry = kremlinLocation
        placemark?.addTapListener(with: self)
        placemark?.setTextWithText(
            "Московский кремль",
            style: YMKTextStyle(size: 8.0,
                                color: .black,
                                outlineWidth: 1.0,
                                outlineColor: .white,
                                placement: .right,
                                offset: 2.0,
                                offsetFromIcon: true,
                                textOptional: false))
        
        let compositeIcon = placemark?.useCompositeIcon()
        compositeIcon?.setIconWithName(
            "pin",
            image: UIImage(systemName: "map.circle")!,
            style: YMKIconStyle(anchor: NSValue(cgPoint: CGPoint(x: 0.5, y: 1.0)), 
                                rotationType: nil,
                                zIndex: 1,
                                flat: true,
                                visible: true,
                                scale: 1.0,
                                tappableArea: nil))
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        } else {
            showToast(title: "Ошибка доступа", message: "Выдайте нужное разрешение на использование геолокации")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let coordinate = location.coordinate
        currentLocation = YMKPoint(latitude: coordinate.latitude, longitude: coordinate.longitude)
        submitRequest()
    }
    
    func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let kremlin = storyboard.instantiateViewController(withIdentifier: "Kremlin")
            self.present(kremlin, animated: true)
        }
        return true
    }
    
    func showToast(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
