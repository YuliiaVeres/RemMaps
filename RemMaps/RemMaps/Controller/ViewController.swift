//
//  ViewController.swift
//  RemMaps
//
//  Created by Yuliia Veresklia on 2/17/16.
//  Copyright © 2016 Yuliia Veresklia. All rights reserved.
//

import UIKit
import MapKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setup()
    }
}

private extension ViewController {
    
    func setup() {
        
        centerMapOnLocation()
        mapView.setupGestures()
    }
    
    func centerMapOnLocation() {
        
        let config = Configs.sharedInstance
        let initialLocation = CLLocationCoordinate2DMake(config.InitialLatitude, config.InitialLongitude)
        
        mapView.setCenterCoordinate(initialLocation, zoomLevel: config.InitialZoomLevel, animated: true)
    }
}

extension ViewController: MKMapViewDelegate {
    
    func mapViewDidFinishLoadingMap(mapView: MKMapView) {
        
        StorageManager.sharedManager.fetchPlaces { places in
            
            self.mainThread({
                guard let unwrappedPlaces = places as [Place]? else { return }
                self.mapView.addAnnoations(unwrappedPlaces)
            })
        }
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
    
        mapView.deselectAnnotation(view.annotation, animated: true)
        mapView.deselectAnnotations()
        
        guard let callout = NSBundle.mainBundle().loadNibNamed(String(AnnotationView), owner: self, options: nil).first as? AnnotationView, let annotation = view.annotation as? Pin else { return }
        
        callout.center = CGPointMake(view.centerOffset.x, view.centerOffset.y - Configs.sharedInstance.CalloutOffset)
        callout.place = annotation.place
        
        view.addSubview(callout)
    }
}
