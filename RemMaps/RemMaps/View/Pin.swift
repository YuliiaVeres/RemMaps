//
//  Pin.swift
//  RemMaps
//
//  Created by Yuliia Veresklia on 2/18/16.
//  Copyright © 2016 Yuliia Veresklia. All rights reserved.
//

import UIKit
import MapKit

final class Pin: NSObject, MKAnnotation {
    
    var place: Place?
    var coordinate: CLLocationCoordinate2D
    
    init(place: Place) {
        
        guard let latitude = place.latitude as Double?, let longitude = place.longitude as Double? else {
            
            self.coordinate = CLLocationCoordinate2DMake(0.0, 0.0)
            super.init()
            
            return }
        
        self.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        self.place = place
        
        super.init()
    }
}
