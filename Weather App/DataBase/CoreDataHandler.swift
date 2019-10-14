
//
//  CoreDataHandler.swift
//
//  Created by Vaisakh krishnan on 10/29/15.
//  Copyright © 2015 eqchat. All rights reserved.
//

import UIKit
import CoreData

public class CoreDataHandler: NSObject {
    @objc public static let sharedInstance = CoreDataHandler()
    
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        managedObjectContext.mergePolicy = NSMergePolicy(merge: NSMergePolicyType.mergeByPropertyObjectTrumpMergePolicyType);

        return managedObjectContext
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("Weather_App" + ".sqlite")
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            let optionDictionary: [NSObject : AnyObject] = [NSMigratePersistentStoresAutomaticallyOption as NSObject: true as AnyObject, NSInferMappingModelAutomaticallyOption as NSObject: true as AnyObject]
            try coordinator!.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: optionDictionary)
        } catch var error1 as NSError {
            error = error1
            coordinator = nil
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            NSLog("Unresolved error \(String(describing: error)), \(error!.userInfo)")
            abort()
        } catch {
            fatalError()
        }
        
        return coordinator
    }()
    
    lazy var applicationDocumentsDirectory: NSURL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1] as NSURL
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
         let modelURL = Bundle.main.url(forResource: "Weather_App", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    
    // MARK: - Entity description for given name.
   @objc public func entityForName(entityName:String)-> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entityName, in: self.managedObjectContext!)!
    }
    
    // MARK: - Create a new entity for given name.
   @objc public func newEntityForName(entityName:String)-> NSManagedObject {
        return NSEntityDescription.insertNewObject(forEntityName: entityName, into: self.managedObjectContext!)
    }
    
    // MARK: - Core Data Saving support
    
   @objc public func saveContext () {
        if managedObjectContext!.hasChanges {
            do {
                try managedObjectContext!.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    @objc public func saveBulkData(data:[NSManagedObject]) {
        let privateMOC = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateMOC.parent = managedObjectContext
        privateMOC.perform {
            for _ in data {
                do {
                    try privateMOC.save()
                    self.managedObjectContext!.performAndWait {
                        do {
                            try self.managedObjectContext!.save()
                        } catch {
                           // fatalError("Failure to save context: \(error)")
                        }
                    }
                } catch {
                   // fatalError("Failure to save context: \(error)")
                }
            }
        }
    }
    
    //MARK:- Core Data Fetch Details
    
    @objc public func getAllDatas(entity:String)-> [AnyObject] {
        let fetchRequest : NSFetchRequest = NSFetchRequest<NSFetchRequestResult> (entityName: entity)
        do {
            return   try self.managedObjectContext!.fetch(fetchRequest)
        }
        catch {
            print(error)
        }
        return [AnyObject]()
    }
    
    @objc public func getAllDatasWithPredicate(entity:String,predicate:NSPredicate?, sortDescriptor: NSSortDescriptor?)-> [AnyObject] {
        let fetchRequest : NSFetchRequest = NSFetchRequest<NSFetchRequestResult> (entityName: entity)
        var resultData:[AnyObject] = []
        if(predicate != nil) {
            fetchRequest.predicate = predicate
        }
        if(sortDescriptor != nil) {
            fetchRequest.sortDescriptors = [sortDescriptor!]
        }
        do {
            resultData =  try self.managedObjectContext!.fetch(fetchRequest) as [AnyObject]
        }catch {
            print(error)
        }
        return resultData
    }
    
    @objc public func getlimitedDatasWithPredicate(entity:String,predicate:NSPredicate?, sortDescriptor: NSSortDescriptor?,limit:Int)-> [AnyObject] {
        let fetchRequest : NSFetchRequest = NSFetchRequest<NSFetchRequestResult> (entityName: entity)
        var resultData:[AnyObject] = []
        if(predicate != nil) {
            fetchRequest.predicate = predicate
        }
        if(sortDescriptor != nil) {
            fetchRequest.sortDescriptors = [sortDescriptor!]
        }
        fetchRequest.fetchLimit = limit
        do {
            resultData =  try self.managedObjectContext!.fetch(fetchRequest) as [AnyObject]
        }catch {
            print(error)
        }
        return resultData
    }
}
