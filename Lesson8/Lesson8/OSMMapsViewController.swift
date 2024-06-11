//
//  OSMMapsViewController.swift
//  Lesson8
//
//  Created by Дарья Никитина on 07.06.2024.
//

import UIKit
import MapKit
import CoreLocation

class OSMMapsViewController: UIViewController,
                             MKMapViewDelegate {
    let locationManager = CLLocationManager()
    
    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.delegate = self
        mapView.showsCompass = true
        mapView.showsScale = true
        return mapView
    }()
    
    var tileRenderer: MKTileOverlayRenderer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.cameraZoomRange = MKMapView.CameraZoomRange(minCenterCoordinateDistance: 1000,
                                                            maxCenterCoordinateDistance: .infinity)
        mapView.cameraBoundary = MKMapView.CameraBoundary(coordinateRegion: MKCoordinateRegion(.world))
        
        createAnnotation(title: "Московский кремль",
                         subtitle: "Московский Кремль — это музей-заповедник, расположенный в самом сердце столицы России. Он включает в себя множество достопримечательностей.",
                         coordinate: CLLocationCoordinate2D(latitude: 55.752004, longitude: 37.617734))
        createAnnotation(title: "Парк Горького",
                         subtitle: "ЦПКиО им. М. Горького является одним из самых популярных мест для отдыха в Москве.",
                         coordinate: CLLocationCoordinate2D(latitude: 55.731683, longitude: 37.603629))
        
        let overlay = OSMMapsTileOverlay()
        overlay.canReplaceMapContent = true
        tileRenderer = MKTileOverlayRenderer(tileOverlay: overlay)
        mapView.addOverlay(overlay, level: .aboveLabels)
        
        mapView.frame = view.bounds
        view.addSubview(mapView)
        let stackView = UIStackView(
            frame: CGRect(x: mapView.frame.width / 2 - 49, y: mapView.frame.height - 140, width: 98, height: 44))
        stackView.spacing = 12
        stackView.distribution = .fillEqually
        mapView.addSubview(stackView)
        
        let zoomButton = createScaleButton(icon: UIImage(systemName: "plus"), action: #selector(zoomMap))
        let unzoomButton = createScaleButton(icon: UIImage(systemName: "minus"), action: #selector(unzoomMap))
        zoomButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        unzoomButton.frame = CGRect(x: 0, y: 54, width: 44, height: 44)
        stackView.addArrangedSubview(zoomButton)
        stackView.addArrangedSubview(unzoomButton)
        
        if locationManager.authorizationStatus == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let tileRenderer else {
            showToast(title: "Ошибка!", message: "Тайла нет после viewDidLoad")
            return MKOverlayRenderer()
        }
        return tileRenderer
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        var annotationView: MKAnnotationView?
        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "osmmaps") {
            annotationView.annotation = annotation
        } else {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "osmmaps")
            annotationView?.canShowCallout = true
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation as? MKPointAnnotation,
              let annotationTitle = annotation.title
        else { return }
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let kremlin =
                storyboard.instantiateViewController(withIdentifier: "Kremlin") as? DetailsViewController
        else {
            return
        }
        kremlin.header = annotationTitle
        if let subtitle = annotation.subtitle {
            kremlin.text = subtitle
        }
        kremlin.modalPresentationStyle = .popover
        present(kremlin, animated: true)
    }
    
    func createAnnotation(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.title = title
        annotation.subtitle = subtitle
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
    
    func createScaleButton(icon: UIImage?, action: Selector) -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.backgroundColor = .white
        button.setImage(icon, for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
    
    @objc func zoomMap() {
        adjustZoomLevel(multiplier: 1/3)
    }
    
    @objc func unzoomMap() {
        adjustZoomLevel(multiplier: 3.0)
    }
    
    func adjustZoomLevel(multiplier: CGFloat) {
        var currentRegion = mapView.region
        currentRegion.span.latitudeDelta *= multiplier
        currentRegion.span.longitudeDelta *= multiplier
        mapView.setRegion(currentRegion, animated: true)
    }
    
    func showToast(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
