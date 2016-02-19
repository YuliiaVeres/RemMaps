//
//  CLGeocoder+RemMaps.swift
//  RemMaps
//
//  Created by Yuliia Veresklia on 2/18/16.
//  Copyright © 2016 Yuliia Veresklia. All rights reserved.
//

import UIKit
import MapKit

extension CLGeocoder {
    
    func composeLocationName(location: CLLocation, completion: ((String, String) -> Void)?) {
        
        reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            var country = ""
            var city = ""
            var street = ""
            
            guard let placeMark = placemarks?.first as CLPlacemark?, let addressInfo = placeMark.addressDictionary as? [String: AnyObject] else { return }
            
            if let placeMarkStreet = addressInfo["Street"] as? String {
                street = "\(placeMarkStreet) "
            }
            
            if let placeMarkCity = addressInfo["City"] as? NSString {
                city = "\(placeMarkCity), "
            }
            
            if let placeMarkCountry = addressInfo["Country"] as? NSString {
                country = "\(placeMarkCountry) "
            }
            
            if completion != nil {
                completion!("\(street)", "\(city)\(country)")
            }
        })
    }
}