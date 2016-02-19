//
//  Any+RemMaps.swift
//  RemMaps
//
//  Created by Yuliia Veresklia on 2/18/16.
//  Copyright © 2016 Yuliia Veresklia. All rights reserved.
//

import UIKit

extension NSObject {
    
    func mainThread(block: (() -> Void)) {
        
        dispatch_async(dispatch_get_main_queue(), block)
    }
}
