//
//  StorageManager.swift
//  RemMaps
//
//  Created by Yuliia Veresklia on 2/18/16.
//  Copyright © 2016 Yuliia Veresklia. All rights reserved.
//

import UIKit
import CoreData
import MapKit

final class StorageManager: NSObject {
    
    static let sharedManager = StorageManager()
    
    private var backgroundContext = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
    private lazy var operationQueue: NSOperationQueue = {
        
        let queue = NSOperationQueue()
        queue.name = "PlaceQueue"
        queue.maxConcurrentOperationCount = 1
        
        return queue
    }()
    
    override init() {
        
        super.init()
        
        guard let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate else { return }
        backgroundContext.persistentStoreCoordinator = appDelegate.persistentStoreCoordinator
    }
    
    func savePlace(title: String, subtitle: String, location: CLLocationCoordinate2D, completion: (Place -> Void)?) {
        
        let saveOperation = NSBlockOperation()
        saveOperation.addExecutionBlock({
            
            self.backgroundContext.performBlockAndWait({ () -> Void in
                
                guard let place = Place.createNewPlace(title, subtitle: subtitle, location: location, context: self.backgroundContext) as Place? else { return }
                
                if completion != nil {
                    completion!(place)
                }
                
                do {
                    try self.backgroundContext.save()
                } catch {}
            })
        })
        
        operationQueue.addOperation(saveOperation)
    }
    
    func fetchPlaces(completion: ([Place]? -> Void)?) {
        
        let fetchRequest = NSFetchRequest(entityName: String(Place))
        backgroundContext.performBlockAndWait { _ in
            
            do {
                guard let results = try self.backgroundContext.executeFetchRequest(fetchRequest) as? [Place] else {
                    return }
                
                if completion != nil {
                    completion!(results)
                }
            } catch {}
        }
    }
}
