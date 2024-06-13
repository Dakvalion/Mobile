//
//  PlacesViewController.swift
//  MireaProject
//
//  Created by Дарья Никитина on 13.06.2024.
//

import UIKit
import YandexMapsMobile
import CoreLocation

class PlacesViewController: UIViewController,
                            CLLocationManagerDelegate,
                            YMKMapObjectTapListener {
    
    let locationManager = CLLocationManager()
    
    lazy var map: YMKMap? = {
        return mapView.mapWindow.map
    }()
    let mapView: YMKMapView = YMKMapView(frame: .zero)
    var currentLocation: YMKPoint = YMKPoint(latitude: 55.648413, longitude: 37.386759)
    var locations: [YMKMapObject: Place] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.frame = view.bounds
        view.addSubview(mapView)
        
        let cameraPosition = YMKCameraPosition(target: currentLocation, zoom: 15.0, azimuth: 0.0, tilt: 0.0)
        mapView.mapWindow.map.move(with: cameraPosition,
                                   animation: YMKAnimation(type: YMKAnimationType.smooth, duration: 0.5))
        
        let zaryadie = Place(name: "Зарядье",
                             description: "Парк культуры и отдыха «Зарядье» расположен в историческом центре Москвы, в непосредственной близости от Красной площади, Кремля и ГУМа.",
                             imagePath: "tree.fill",
                             point: YMKPoint(latitude: 55.751142, longitude: 37.627937))
        addPlacemark(place: zaryadie)
        let stolovaya57 = Place(name: "Столовая №57",
                                description: "Столовая «Столовая № 57» находится в ГУМе, в самом сердце Москвы. Гостям нравится разнообразное меню, в котором можно найти блюда из «Книги о вкусной и здоровой пище», а также вегетарианские, веганские и диетические блюда.",
                                imagePath: "fork.knife", 
                                point: YMKPoint(latitude: 55.754242, longitude: 37.623210))
        addPlacemark(place: stolovaya57)
        let veterok = Place(name: "Ровесник", 
                            description: "Трехэтажное заведение, стилизованное под СССР времен застоя, с неоновыми вывесками, хрустальными люстрами, коврами, растениями и винтажной мебелью.",
                            imagePath: "wineglass.fill", point: YMKPoint(latitude: 55.762424, longitude: 37.605921))
        addPlacemark(place: veterok)
        let mac = Place(name: "Вкусно и точка", description: "Бургерная быстрого питания, которая находится в центре Москвы, недалеко от станции метро Третьяковская и Третьяковской галереи.",
                        imagePath: "fork.knife", point: YMKPoint(latitude: 55.740988, longitude: 37.625406))
        addPlacemark(place: mac)
        
        locationManager.delegate = self
        if locationManager.authorizationStatus != .authorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        } else {
            locationManager.startUpdatingLocation()
        }
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
    }
    
    func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
        DispatchQueue.main.async {
            if let location = self.locations[mapObject] {
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                guard let details = storyboard.instantiateViewController(withIdentifier: "Kremlin") as? DetailsViewController else { return }
                CLGeocoder().reverseGeocodeLocation(
                    CLLocation(latitude: point.latitude, longitude: point.longitude),
                    preferredLocale: Locale(identifier: "ru")
                ) { (placemarks, error) in
                    if let error = error {
                        print("Ошибка: \(error.localizedDescription)")
                        return
                    }
                    if let placemark = placemarks?.first,
                       let address = placemark.name {
                        details.place = location
                        details.address = address
                        self.present(details, animated: true)
                    }
                }
            }
        }
        return true
    }
    
    func showToast(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func addPlacemark(place: Place) {
        let placemark = map?.mapObjects.addPlacemark()
        placemark?.geometry = place.point
        placemark?.addTapListener(with: self)
        placemark?.setTextWithText(place.name,
                                   style: YMKTextStyle(size: 8.0,
                                                       color: .black,
                                                       outlineWidth: 1.0,
                                                       outlineColor: .white,
                                                       placement: .right,
                                                       offset: 2.0,
                                                       offsetFromIcon: true,
                                                       textOptional: false))
        
        let compositeIcon = placemark?.useCompositeIcon()
        compositeIcon?.setIconWithName("pin",
                                       image: UIImage(systemName: place.imagePath)!,
                                       style: YMKIconStyle(anchor: NSValue(cgPoint: CGPoint(x: 0.5, y: 1.0)),
                                                           rotationType: nil,
                                                           zIndex: 1,
                                                           flat: true,
                                                           visible: true,
                                                           scale: 1.0,
                                                           tappableArea: nil))
        locations[placemark!] = place
    }
}
