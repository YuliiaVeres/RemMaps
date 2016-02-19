//
//  MapView+RemMaps.swift
//  RemMaps
//
//  Created by Yuliia Veresklia on 2/18/16.
//  Copyright © 2016 Yuliia Veresklia. All rights reserved.
//

import UIKit
import MapKit

extension MKMapView {
    
    private struct AssociatedKeys {
        
        static var shouldAddAnotation = true
    }
    
    var shouldAddAnotation: Bool {
        get {
            guard let input = objc_getAssociatedObject(self, &AssociatedKeys.shouldAddAnotation) as? Bool else {
                return true
            }
            return input
        }
        
        set(value) {
            objc_setAssociatedObject(self,&AssociatedKeys.shouldAddAnotation, value,objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func setupGestures() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "addNewAnnotation:")
        tapGesture.delegate = self
        addGestureRecognizer(tapGesture)
    }
    
    func addAnnoations(places: [Place]) {
        
        for place in places {
            
            let annotation = Pin(place: place)
            self.addAnnotation(annotation)
        }
    }
    
    func hideCallouts() {
    
        for annotation in annotations {
        
            let view = viewForAnnotation(annotation)
            view?.hideCallout()
        }
    }
}

private extension MKMapView {
    
    @objc func addNewAnnotation(tap: UITapGestureRecognizer) {
        
        if shouldAddAnotation == false {
            return
        }
        
        let coordinate = convertPoint(tap.locationInView(self), toCoordinateFromView: self)
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geoCoder.composeLocationName(location) { title, subtitle in
            
            StorageManager.sharedManager.savePlace(title, subtitle: subtitle, location: coordinate, completion: { place in
                
                self.mainThread({
                    
                    let annotation = Pin(place: place)
                    self.addAnnotation(annotation)
                })
            })
        }
    }
}

extension MKMapView: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        
        guard let isAnnotationView = touch.view?.isKindOfClass(MKAnnotationView) as Bool? else { return true }
        shouldAddAnotation = !isAnnotationView
        
        return true
    }
}
