//
//  Configs.swift
//  RemMaps
//
//  Created by Yuliia Veresklia on 2/18/16.
//  Copyright © 2016 Yuliia Veresklia. All rights reserved.
//

import UIKit

final class Configs: NSObject {

    static let sharedInstance = Configs()
    
    let InitialLatitude = 49.839683
    let InitialLongitude = 24.029717
    let InitialZoomLevel: UInt = 10
    
    let CalloutOffset: CGFloat = 27.0
    
    let CalloutAnimationDuration: Double = 1.0
}

