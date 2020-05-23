//
//  AppDelegate.swift
//  stackFoodGame
//
//  Created by Michael Hayes on 5/6/20.
//  Copyright © 2020 Michael Hayes. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let coreDataManager = CoreDataManager(modelName: "stackFoodGame") //AHHHH the s is small case AHHHHH!!!

    // MARK: Temporary variables
    /* The following variables are added temporarily to make Perks.Controller run properly. I will be removing these and replacing them with arrays, some of which could be stored as Core Data. */
    var itemQuantity: Int = 0;
    var perkImages: [UIImage] = [UIImage(named: "snail.png")!, UIImage(named: "tips.jpeg")!, UIImage(named: "magnet.png")!, UIImage(named: "chef.jpg")!, UIImage(named: "gold.png")!, UIImage(named: "secret.jpg")!]
    var perkDescriptions: [String] = ["This snail will slow down the speed of ites falling by 5% for you!", "Increase the total tip amount by 10%", "Attract the ingredients towards your burger, making it easier to collect them!", "This chef will make your engridients delicious! Increase the money earned from a completed order by 10%", "Gold rush! All your ingredients will be covered in gold, giving you a 100% bonus for money earned from a completed order!", "Unlock a mystery ingredient, which, if collected, will give you an immense amount of money and experience!"]

    var perkSpeed: Int = 0
    var perkTips: Int = 0
    var perkMagnet: Int = 0
    var perkChef: Int = 0
    var perkGold: Int = 0
    var perkSecret: Int = 0

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
                    
        print(coreDataManager.managedObjectContext)//prints node
        
        let managedObjectContext = coreDataManager.managedObjectContext //This returns node for object context
        
        let _ = createRecordForEntity("Player", inManagedObjectContext: managedObjectContext) //Method to insert entity into MOC (managed object context)
        
        //-------------------------------------------------------> fetching
        
        var player: NSManagedObject? = nil
        
        let players = fetchRecordsForEntity("Player", inManagedObjectContext: managedObjectContext)
        
        if let p_record = players.first{ //this block basically make sure there is at least 1 element within entity, sets player to the first one
            
            player = p_record
        }else if let p_record = createRecordForEntity("Player", inManagedObjectContext: managedObjectContext){
            player = p_record
        }
        
        print("Num of entities: \(players.count)") //just printing
        print(player as Any)
        print("coins : " + String(player?.value(forKey: "coins") as! Int))
        
        //--------------------------------------------------------------> end of fetching
        
        
        //--------------------------------------------------------------> updating attribute/relationship
        if let player = player {
            print(player.value(forKey: "coins") ?? "no coins")
            print(player.value(forKey: "name") ?? "no name")

                player.setValue(5, forKey: "coins")

                player.setValue("nathan", forKey: "name")
            
        } else {
            print("unable to fetch or create list")
        }
        
        //-------------------------------------------------------------->
        
        
        do{
            try managedObjectContext.save() //Saving MOC into persistant container through CoreDataManager
            
        }catch{print("FAILED TO SAVE CONTEXT")}
        
        
        
        /* UNCOMMENT FOR 1st VERSION
         
        let managedObjectContext = coreDataManager.managedObjectContext
        
        let entityDescription = NSEntityDescription.entity(forEntityName: "Player", in: managedObjectContext)
        
        if  let entityDescription = entityDescription {
            /*
            print(entityDescription.name ?? "No Name")
            print(entityDescription.properties) //print out JSON data about Entity*/
            
            let player = NSManagedObject(entity: entityDescription, insertInto: managedObjectContext) //Creates new entity within CoreData
            
            // print(String(player.value(forKey: "coins") as! Int)) // <- money maker right here
            
            print(player) //More JSON about Entity
            
            do{
                try managedObjectContext.save()
            }catch{}
            
        } */

        
        return true
    }
    
    
    
    private func createRecordForEntity(_ entity: String, inManagedObjectContext managedObjectContext: NSManagedObjectContext) -> NSManagedObject? {
        // Helpers
        var result: NSManagedObject?

        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: entity, in: managedObjectContext)

        if let entityDescription = entityDescription {
            // Create Managed Object
            result = NSManagedObject(entity: entityDescription, insertInto: managedObjectContext)
        }

        //return an NSManagedObject that holds all the parameters created in +CoreDataProperties
        return result
    }
    
    private func fetchRecordsForEntity(_ entity: String, inManagedObjectContext managedObjectContext: NSManagedObjectContext) -> [NSManagedObject] {
        // Create Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity) //using entityName: entity in order to load description to MOC

        // Helpers
        var result = [NSManagedObject]()

        do {
            // Execute Fetch Request
            let records = try managedObjectContext.fetch(fetchRequest)

            if let records = records as? [NSManagedObject] {
                result = records
            }

        } catch {
            print("Unable to fetch managed objects for entity \(entity).")
        }

        return result
    }
    

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.

    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "stackFoodGame")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            
            
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

