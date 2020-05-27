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
    var perkImages: [UIImage] = [UIImage(named: "snail.png")!, UIImage(named: "tips.jpeg")!, UIImage(named: "gordon.jpeg")!, UIImage(named: "chef.jpg")!, UIImage(named: "gold.png")!, UIImage(named: "secret.jpg")!]
    var perkDescriptions: [String] = ["This snail will slow down the speed of ites falling by 5% for you!", "Increase the total tip amount by 10%", "Gordon Ramsay will visit you, increasing your experience earned by 10%!", "This chef will make your engridients delicious! Increase the money earned!", "All your ingredients will be golden, giving you a 100% bonus for money earned!", "Unlock a mystery ingredient, giving you tons of money and experience!"]

    var perkSpeed: Double = 1.0
    var perkTips: Double = 1.0
    var perkGordon: Double = 0.0
    var perkChef: Double = 0.0
    var perkGold: Double = 0.0
    var perkSecret: Double = 0.0


    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
                    
        print(coreDataManager.managedObjectContext)//prints node
        
        let managedObjectContext = coreDataManager.managedObjectContext //This returns node for object context
        
        
        //setting the stage for a player-centric model
        let players = getRecordsFor(entity: "Player") //fetchRecordsForEntity("Player", inManagedObjectContext: managedObjectContext)
        
        var player : NSManagedObject? = nil
        
        if let p_record = players.first{ //this block basically make sure there is at least 1 element within entity, sets player to the first one
            
            player = p_record
        }else if let p_record = createRecordForEntity("Player", inManagedObjectContext: managedObjectContext){
            player = p_record
        

        //player?.setValue(0, forKey: "value")
            
        saveAllEntityData()
        }
        
        print("APP DELEGATE: ")
        let pllayr = getRecordsFor(entity: "Player").first
        print(pllayr as Any)
        
        if pllayr == nil{
            let atro = createEntity(entity: "Player")
            atro?.setValue(0, forKey: "value")
            saveAllEntityData()
        }
        
        print("APP DELEGATE2: ")
        
        //doit()
        let pllayr2 = getRecordsFor(entity: "Player").first
        print(pllayr2 as Any)
        
        /*
        
        if players.count != 1 { //make sure that there is only 1 player on start
            for p in players{
                managedObjectContext.delete(p)
                print("deleted player")
            }
            let _ = createRecordForEntity("Player", inManagedObjectContext: managedObjectContext)
            
            saveAllEntityData()
            let iplayer = getRecordsFor(entity: "Player").first
            iplayer?.setValue(10, forKey: "level")
            saveAllEntityData()
            let oplayer = getRecordsFor(entity: "Player").first
            oplayer?.setValue(10, forKey: "level")
            saveAllEntityData()

        }
        
        var player: NSManagedObject? = nil
        if let precord = players.first{
            player = precord
        }
        
        if player == nil{
            player = createRecordForEntity("Player", inManagedObjectContext: managedObjectContext)
            saveAllEntityData()
            
            let iplayer = getRecordsFor(entity: "Player").first
            iplayer?.setValue(0, forKey: "level")
            saveAllEntityData()


        }*/
        
        
        
        
        //initialize player variables
        
        
        print("AppDelegate> PLAYERS: \(players.count) (make sure this is 1 on start)")
        //print(player as Any) //prints the FAULT not object
                
        
        /*
        if let player = player {
            print(player.value(forKey: "coins") ?? "no coins")

                player.setValue(5, forKey: "coins")
            
        } else {
            print("unable to fetch or create list")
        }*/
        
        
        
        //print(player?.value(forKey: "coins") as Any) //HOW TO GET COINS

        //player?.setValue(0, forKey: "coins") //set value for coins
        
        //saveAllEntityData()
        
        //print(player?.value(forKey: "coins") as Any)
        
        
        
        let avatars = getRecordsFor(entity: "Avatar")   // Loads in BoyChef as starting character
        var avatar : NSManagedObject? = nil
        
        if let a_record = avatars.first{ //this block basically make sure there is at least 1 element within entity, sets player to the first one
            
            avatar = a_record
        }else if let a_record = createRecordForEntity("Avatar", inManagedObjectContext: managedObjectContext){
            avatar = a_record
        
        
        

        avatar?.setValue(1, forKey: "id")
        avatar?.setValue("boychef", forKey: "name")
        avatar?.setValue("boychef", forKey: "iconName")
        
        
        player?.setValue(avatar, forKey: "avatar")
        //print(avatar as Any)
        
        saveAllEntityData()
        }
        
        print("APP DELEGATE: ")
        let playr = getRecordsFor(entity: "Player").first
        print(playr?.value(forKey: "avatar") as Any)
        
        if playr?.value(forKey: "avatar") == nil{
            let atr = createEntity(entity: "Avatar")
            atr?.setValue(1, forKey: "id")
            atr?.setValue("boychef", forKey: "name")
            atr?.setValue("boychef", forKey: "iconName")
            playr?.setValue(atr, forKey: "avatar")
            saveAllEntityData()
        }
        
        print("APP DELEGATE2: ")
        
        //doit()
        let playr2 = getRecordsFor(entity: "Player").first
        print(playr2?.value(forKey: "avatar") as Any)
            
        
        print(" LEVEL #: \(playr2?.value(forKey: "level") as! Int)")
        
        /*
        let play2 = getRecordsFor(entity: "Player").first
        let k = play2?.value(forKey: "level") as! Int
        play2?.setValue(k + 1, forKey: "level")*/
        saveAllEntityData()
        
        
        
        
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
    
    func getRecordsFor(entity: String) -> [NSManagedObject] {
        let managedObjectContext = coreDataManager.managedObjectContext
        
        let entities = fetchRecordsForEntity(entity, inManagedObjectContext: managedObjectContext)
        
        return entities
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
    
    func createEntity(entity: String) -> NSManagedObject?{
        let managedObjectContext = coreDataManager.managedObjectContext

        let result = createRecordForEntity(entity, inManagedObjectContext: managedObjectContext)
        
        return result
        
    }
    
    
    func saveAllEntityData(){
        let managedObjectContext =  coreDataManager.managedObjectContext
        
            do{
                try managedObjectContext.save() //Saving MOC into persistant container through CoreDataManager
                print("MOC> Succesfully saved!")
            }catch{
                print("MOC> FAILED TO SAVE CONTEXT")
                
            }
        
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

