//
//  persistanceService.swift
//  stackFoodGame
//
//  Created by Nathan on 5/22/20.
//  Copyright © 2020 Michael Hayes. All rights reserved.
//


import Foundation
import CoreData

class persistenceService {
    
    private init() {}
    
    static var context: NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    
    static var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "stackFoodGame")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("oops thats bad \(error), \(error.userInfo)")
            }
            
            
            
        })
        return container
    }()
    
    static func saveContext() { // can be called from view controller and will save stashed changes as well as handle errors
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do{
                try context.save()
                print("SAVED!")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
            
        }
    }
    
    
}
