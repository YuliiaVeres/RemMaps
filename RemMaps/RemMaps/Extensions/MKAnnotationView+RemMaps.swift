//
//  MKAnnotationView+RemMaps.swift
//  RemMaps
//
//  Created by Yuliia Veresklia on 2/19/16.
//  Copyright © 2016 Yuliia Veresklia. All rights reserved.
//

import UIKit
import MapKit

extension MKAnnotationView {

    func hideCallout() {
    
        for view in subviews {
        
            guard let annotationView = view as? AnnotationView else { continue }
            annotationView.removeFromSuperview()
        }
    }
}
