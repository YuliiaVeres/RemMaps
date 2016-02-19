//
//  Place.swift
//  RemMaps
//
//  Created by Yuliia Veresklia on 2/18/16.
//  Copyright © 2016 Yuliia Veresklia. All rights reserved.
//

import Foundation
import CoreData
import MapKit

final class Place: NSManagedObject {

    class func createNewPlace(title: String, subtitle: String, location: CLLocationCoordinate2D, context: NSManagedObjectContext) -> Place? {
    
        guard let place = NSEntityDescription.insertNewObjectForEntityForName(String(Place), inManagedObjectContext: context) as? Place else { return nil }
        place.title = title
        place.subtitle = subtitle
        place.longitude = NSNumber(double: location.longitude)
        place.latitude = NSNumber(double: location.latitude)
        
        return place
    }
}
