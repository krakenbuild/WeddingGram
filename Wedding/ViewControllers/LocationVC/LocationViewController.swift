//
//  LocationViewController.swift
//  Wedding
//
//  Created by Personal on 22/10/17.
//  Copyright © 2017 Alberto Josue Gonzalez Juarez. All rights reserved.
//

import UIKit
import MapKit
class LocationViewController: UIViewController {
  
  @IBOutlet weak var locationEventMap: MKMapView!
  let regionRadius: CLLocationDistance = 800
  let initialLocation = CLLocation(latitude: 19.633513, longitude: -99.096468)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Ubicación"
    locationEventMap.delegate = self
    centerMapOnLocation(location: initialLocation)
    
    let chapalasLocation = CLLocationCoordinate2DMake(19.633513, -99.096468)
    let anotation = MKPointAnnotation()
    anotation.coordinate = chapalasLocation
    anotation.title = "Eleonora & Egbert"
    locationEventMap.addAnnotation(anotation)
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // Hide the navigation bar on the this view controller
    self.navigationController?.setNavigationBarHidden(false, animated: animated)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func centerMapOnLocation(location: CLLocation) {
    let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                              regionRadius * 2.0, regionRadius * 2.0)
    locationEventMap.setRegion(coordinateRegion, animated: true)
  }
  
  @objc func openMapForPlace() {
    
    let latitude: CLLocationDegrees = 19.633513
    let longitude: CLLocationDegrees = -99.096468
    
    let regionDistance:CLLocationDistance = 10000
    let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
    let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
    let options = [
      MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
      MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
    ]
    let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
    let mapItem = MKMapItem(placemark: placemark)
    mapItem.name = "Eleonora & Egbert"
    mapItem.openInMaps(launchOptions: options)
  }
}

extension LocationViewController: MKMapViewDelegate {
  
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    // Don't want to show a custom image if the annotation is the user's location.
    guard !(annotation is MKUserLocation) else {
      return nil
    }
    
    // Better to make this class property
    let annotationIdentifier = "AnnotationIdentifier"
    
    var annotationView: MKAnnotationView?
    if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
      annotationView = dequeuedAnnotationView
      annotationView?.annotation = annotation
    }
    else {
      annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
      let directionsButton = UIButton(type: .detailDisclosure)
      directionsButton.addTarget(self, action: #selector(openMapForPlace), for: .touchUpInside)
      annotationView?.rightCalloutAccessoryView = directionsButton
    }
    
    if let annotationView = annotationView {
      // Configure your annotation view here
      annotationView.canShowCallout = true
      annotationView.image = UIImage(named: "Pin_chilaquil.png")
      
    }
    
    return annotationView
  }
}

