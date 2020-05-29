//
//  ViewController.swift
//  stackFoodGame
//
//  Created by Nakul Nandhakumar on 5/7/20.
//  Copyright © 2020 Nakul Nandhakumar. All rights reserved.
//
import UIKit
import CoreData


class LocationCustomizationController: UIViewController {
    
    @IBOutlet weak var LocCustomPic1: UIImageView!
    @IBOutlet weak var LocCustomPic2: UIImageView!
    @IBOutlet weak var LocCustomPic3: UIImageView!
    @IBOutlet weak var LocCustomPic4: UIImageView!
    @IBOutlet weak var LocCustomPic5: UIImageView!
    @IBOutlet weak var LocCustomPic6: UIImageView!
    @IBOutlet weak var LocCustomPic7: UIImageView!
    @IBOutlet weak var LocCustomPic8: UIImageView!
    @IBOutlet weak var LocCustomPic9: UIImageView!
    @IBOutlet weak var LocIcon1: UIImageView!
    @IBOutlet weak var LocIcon2: UIImageView!
    @IBOutlet weak var LocIcon3: UIImageView!
    
    @IBOutlet weak var LocPic1: UIImageView!
    @IBOutlet weak var LocPic2: UIImageView!
    @IBOutlet weak var LocPic3: UIImageView!
    @IBOutlet weak var LocPic4: UIImageView!
    @IBOutlet weak var LocPic5: UIImageView!
    @IBOutlet weak var LocPic6: UIImageView!
    @IBOutlet weak var LocPic7: UIImageView!
    @IBOutlet weak var LocPic8: UIImageView!
    @IBOutlet weak var LocPic9: UIImageView!
    @IBOutlet weak var LocimageDisplay: UIImageView!
    
    @IBOutlet weak var LocPressPic1: UIButton!
    @IBOutlet weak var LocPressPic2: UIButton!
    @IBOutlet weak var LocPressPic3: UIButton!
    @IBOutlet weak var LocPressPic4: UIButton!
    @IBOutlet weak var LocPressPic5: UIButton!
    @IBOutlet weak var LocPressPic6: UIButton!
    @IBOutlet weak var LocPressPic7: UIButton!
    @IBOutlet weak var LocPressPic8: UIButton!
    @IBOutlet weak var LocPressPic9: UIButton!
    
    var LoctabCount = Int()
    var Locid = Int()
    var LocimageName = String()
    var LociconName = String()
    
    var LocmyIcon = String()
    var LocimageNameData = [1:"defaultcity",2:"carnival",3:"stadium",4:"skycity",5:"playground",6:"basketballcourt",7:"sunsetcity",8:"farm",9:"beach"]
    
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    var player : NSManagedObject?
    var location : NSObject?

    override func viewDidLoad() {
        LocgetData()
        Locidchecker(Locid: Locid)
        LoctabCountChecker(LoctabCount: LoctabCount)
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true

            
            /* Load Data for different Avatars here with
             
             
            avatars.append((appDelegate?.createEntity(entity: "Avatar"))!) //creating and loading avatars
            avatars[0].setValue(0, forKey: "locid")
            avatars[0].setValue("stadium", forKey: "locname")
            
            let player = appDelegate?.getRecordsFor(entity: "Player").first
            player?.setValue(avatars, forKey: "avatar")
            
            appDelegate?.saveAllEntityData() */
            
            
        player = appDelegate?.getRecordsFor(entity: "Player").first
        location = player?.value(forKey: "location") as? NSObject
        
        LocmyIcon = location!.value(forKey: "lociconName") as! String
        
        print("LocationCustomization> id = " + String(location!.value(forKey: "locid") as! Int) + " name = " + String(location!.value(forKey: "locname") as! String))
            
        setPicture()
        
    }
    
    func setPicture(){
        LocimageDisplay.image = UIImage(named: LocmyIcon)
    }
    
    
    func editLocation(LocimageID: Int) -> Void {
        LocmyIcon = LocimageNameData[LocimageID]!
        location?.setValue(LocimageID, forKey: "locid")
        location?.setValue(LocmyIcon, forKey: "locname")
        location?.setValue(LocmyIcon, forKey: "lociconName")
        appDelegate?.saveAllEntityData()
        setPicture()

    }
    
    
    
    @IBAction func LocPressPic1(_ sender: Any)
    {
        Locid = 1
        LocimageName = "defaultcity"
        LociconName = "defaultcity"
        let Loccontext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let Count = NSEntityDescription.entity(forEntityName: "Location", in: Loccontext)
        let newCount = NSManagedObject(entity: Count!, insertInto:  Loccontext)
        
        newCount.setValue(Locid, forKey: "locid")
        newCount.setValue(LoctabCount, forKey: "loctabCount")
        newCount.setValue(LocimageName, forKey: "locname")
        newCount.setValue(LociconName, forKey: "lociconName")
        do {
            try Loccontext.save()
            print("Save successful")
            LocgetData()
        } catch {
            print("Save failed")
        }
        Locidchecker(Locid: Locid)
        
        editLocation(LocimageID: Locid)

    }
    
    @IBAction func LocPressPic2(_ sender: Any)
    {
        Locid = 2
        LocimageName = "carnival"
        LociconName = "carnival"
        let Loccontext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
         
         let Count = NSEntityDescription.entity(forEntityName: "Location", in: Loccontext)
         let newCount = NSManagedObject(entity: Count!, insertInto:  Loccontext)
         
         newCount.setValue(Locid, forKey: "locid")
         newCount.setValue(LoctabCount, forKey: "loctabCount")
         newCount.setValue(LocimageName, forKey: "locname")
         newCount.setValue(LociconName, forKey: "lociconName")
         do {
             try Loccontext.save()
             print("Save successful")
             LocgetData()
         } catch {
             print("Save failed")
         }
        Locidchecker(Locid: Locid)
        
        editLocation(LocimageID: Locid)
    }
    
    @IBAction func LocPressPic3(_ sender: Any)
    {
        Locid = 3
        LocimageName = "stadium"
        LociconName = "stadium"
        let Loccontext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
         
         let Count = NSEntityDescription.entity(forEntityName: "Location", in: Loccontext)
         let newCount = NSManagedObject(entity: Count!, insertInto:  Loccontext)
         
         newCount.setValue(Locid, forKey: "locid")
         newCount.setValue(LoctabCount, forKey: "loctabCount")
         newCount.setValue(LocimageName, forKey: "locname")
         newCount.setValue(LociconName, forKey: "lociconName")
         do {
             try Loccontext.save()
             print("Save successful")
             LocgetData()
         } catch {
             print("Save failed")
         }
        Locidchecker(Locid: Locid)
        
        editLocation(LocimageID: Locid)

    }
    
    @IBAction func LocPressPic4(_ sender: Any)
    {
        /*
        Avatar Table
        1 defaultcity
        2 carnival
        3 skycity
        
        fetch - avatar -- get only locid 4
        
        fetch - player: go to player.first
        
        player.avatar = avatar
        
        save()*/
        
        
        Locid = 4
        LocimageName = "skycity"
        LociconName = "skycity"
        let Loccontext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
         
         let Count = NSEntityDescription.entity(forEntityName: "Location", in: Loccontext)
         let newCount = NSManagedObject(entity: Count!, insertInto:  Loccontext)
         
         newCount.setValue(Locid, forKey: "locid")
         newCount.setValue(LoctabCount, forKey: "loctabCount")
         newCount.setValue(LocimageName, forKey: "locname")
         newCount.setValue(LociconName, forKey: "lociconName")
         do {
             try Loccontext.save()
             print("Save successful")
             LocgetData()
             print(LocimageName)
             print(LociconName)
         } catch {
             print("Save failed")
         }
        Locidchecker(Locid: Locid)
        
        editLocation(LocimageID: Locid)

    }
    
    @IBAction func LocPressPic5(_ sender: Any)
    {
        Locid = 5
        LocimageName = "playground"
        LociconName = "playground"
        let Loccontext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
             
        let Count = NSEntityDescription.entity(forEntityName: "Location", in: Loccontext)
        let newCount = NSManagedObject(entity: Count!, insertInto:  Loccontext)
             
        newCount.setValue(Locid, forKey: "locid")
        newCount.setValue(LoctabCount, forKey: "loctabCount")
        newCount.setValue(LocimageName, forKey: "locname")
        newCount.setValue(LociconName, forKey: "lociconName")
        do {
            try Loccontext.save()
            print("Save successful")
            LocgetData()
            print(LocimageName)
            print(LociconName)
        } catch {
            print("Save failed")
        }
        Locidchecker(Locid: Locid)
            
        editLocation(LocimageID: Locid)

    }
        
    
    @IBAction func LocPressPic6(_ sender: Any)
    {
        Locid = 6
        LocimageName = "basketballcourt"
        LociconName = "basketballcourt"
        let Loccontext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
             
        let Count = NSEntityDescription.entity(forEntityName: "Location", in: Loccontext)
        let newCount = NSManagedObject(entity: Count!, insertInto:  Loccontext)
             
        newCount.setValue(Locid, forKey: "locid")
        newCount.setValue(LoctabCount, forKey: "loctabCount")
        newCount.setValue(LocimageName, forKey: "locname")
        newCount.setValue(LociconName, forKey: "lociconName")
        do {
            try Loccontext.save()
            print("Save successful")
            LocgetData()
            print(LocimageName)
            print(LociconName)
        } catch {
            print("Save failed")
        }
        Locidchecker(Locid: Locid)
            
        editLocation(LocimageID: Locid)

    }
    
    @IBAction func LocPressPic7(_ sender: Any)
    {
        Locid = 7
        LocimageName = "sunsetcity"
        LociconName = "sunsetcity"
        let Loccontext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
             
        let Count = NSEntityDescription.entity(forEntityName: "Location", in: Loccontext)
        let newCount = NSManagedObject(entity: Count!, insertInto:  Loccontext)
             
        newCount.setValue(Locid, forKey: "locid")
        newCount.setValue(LoctabCount, forKey: "loctabCount")
        newCount.setValue(LocimageName, forKey: "locname")
        newCount.setValue(LociconName, forKey: "lociconName")
        do {
            try Loccontext.save()
            print("Save successful")
            LocgetData()
            print(LocimageName)
            print(LociconName)
        } catch {
            print("Save failed")
        }
        Locidchecker(Locid: Locid)
            
        editLocation(LocimageID: Locid)

    }
    
    @IBAction func LocPressPic8(_ sender: Any)
    {
        Locid = 8
        LocimageName = "farm"
        LociconName = "farm"
        let Loccontext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
             
        let Count = NSEntityDescription.entity(forEntityName: "Location", in: Loccontext)
        let newCount = NSManagedObject(entity: Count!, insertInto:  Loccontext)
             
        newCount.setValue(Locid, forKey: "locid")
        newCount.setValue(LoctabCount, forKey: "loctabCount")
        newCount.setValue(LocimageName, forKey: "locname")
        newCount.setValue(LociconName, forKey: "lociconName")
        do {
            try Loccontext.save()
            print("Save successful")
            LocgetData()
            print(LocimageName)
            print(LociconName)
        } catch {
            print("Save failed")
        }
        Locidchecker(Locid: Locid)
            
        editLocation(LocimageID: Locid)

    }
    
    @IBAction func LocPressPic9(_ sender: Any)
    {
        Locid = 9
        LocimageName = "beach"
        LociconName = "beach"
        let Loccontext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
             
        let Count = NSEntityDescription.entity(forEntityName: "Location", in: Loccontext)
        let newCount = NSManagedObject(entity: Count!, insertInto:  Loccontext)
             
        newCount.setValue(Locid, forKey: "locid")
        newCount.setValue(LoctabCount, forKey: "loctabCount")
        newCount.setValue(LocimageName, forKey: "locname")
        newCount.setValue(LociconName, forKey: "lociconName")
        do {
            try Loccontext.save()
            print("Save successful")
            LocgetData()
            print(LocimageName)
            print(LociconName)
        } catch {
            print("Save failed")
        }
        Locidchecker(Locid: Locid)
            
        editLocation(LocimageID: Locid)

    }
    
    @IBAction func NextArrow(_ sender: Any)
    {
        LoctabCount += 1
        let Loccontext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let Count = NSEntityDescription.entity(forEntityName: "Location", in: Loccontext)
        let newCount = NSManagedObject(entity: Count!, insertInto:  Loccontext)
        
        newCount.setValue(LoctabCount, forKey: "loctabCount")
        newCount.setValue(Locid, forKey: "locid")
        newCount.setValue(LocimageName, forKey: "locname")
        newCount.setValue(LociconName, forKey: "lociconName")
        do {
            try Loccontext.save()
            print("Save successful")
            LocgetData()
        } catch {
            print("Save failed")
        }
        LoctabCountChecker(LoctabCount: LoctabCount)
    }
    
    @IBAction func PreviousArrow(_ sender: Any)
    {
        LoctabCount += 1
        let Loccontext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let Count = NSEntityDescription.entity(forEntityName: "Location", in: Loccontext)
        let newCount = NSManagedObject(entity: Count!, insertInto:  Loccontext)
        
        newCount.setValue(LoctabCount, forKey: "loctabCount")
        newCount.setValue(Locid, forKey: "locid")
        newCount.setValue(LocimageName, forKey: "locname")
        newCount.setValue(LociconName, forKey: "lociconName")
        do {
            try Loccontext.save()
            print("Save successful")
            LocgetData()
        } catch {
            print("Save failed")
        }
        LoctabCountChecker(LoctabCount: LoctabCount)
    }

    func LocgetData()
    {
        let Loccontext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let Locrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Location")
        Locrequest.returnsObjectsAsFaults = false
        do
        {
            let Locresult = try Loccontext.fetch(Locrequest)
            for data in Locresult as! [NSManagedObject]
            {
                LoctabCount = data.value(forKey: "loctabCount") as! Int
                Locid = data.value(forKey: "locid") as! Int
                LocimageName = data.value(forKey: "locname") as! String
                LociconName = data.value(forKey: "lociconName") as! String
            }
            print("Data successfully fetched")
        }
        catch
        {
            print("Fetch failed")
        }
    }
    
    func Locidchecker(Locid: Int)
    {
        if Locid != -1 {
            LocPic1.isHidden = true
            LocPic2.isHidden = true
            LocPic3.isHidden = true
            LocPic4.isHidden = true
            LocPic5.isHidden = true
            LocPic6.isHidden = true
            LocPic7.isHidden = true
            LocPic8.isHidden = true
            LocPic9.isHidden = true
        }
        /*
        if locid == 1 {
            Pic1.isHidden = false
            Pic2.isHidden = true
            Pic3.isHidden = true
            Pic4.isHidden = true
            Pic5.isHidden = true
            Pic6.isHidden = true
        }
        if locid == 2 {
            Pic1.isHidden = true
            Pic2.isHidden = false
            Pic3.isHidden = true
            Pic4.isHidden = true
            Pic5.isHidden = true
            Pic6.isHidden = true
        }
        if locid == 3 {
            Pic1.isHidden = true
            Pic2.isHidden = true
            Pic3.isHidden = false
            Pic4.isHidden = true
            Pic5.isHidden = true
            Pic6.isHidden = true
        }
        if locid == 4 {
            Pic1.isHidden = true
            Pic2.isHidden = true
            Pic3.isHidden = true
            Pic4.isHidden = false
            Pic5.isHidden = true
            Pic6.isHidden = true
        }
        if locid == 5 {
            Pic1.isHidden = true
            Pic2.isHidden = true
            Pic3.isHidden = true
            Pic4.isHidden = true
            Pic5.isHidden = false
            Pic6.isHidden = true
        }
        if locid == 6 {
            Pic1.isHidden = true
            Pic2.isHidden = true
            Pic3.isHidden = true
            Pic4.isHidden = true
            Pic5.isHidden = true
            Pic6.isHidden = false
        } */
    }
    
    func LoctabCountChecker(LoctabCount: Int)
    {
        if (LoctabCount.magnitude % 3) == 0 {
            LocCustomPic1.isHidden = false
            LocCustomPic2.isHidden = false
            LocCustomPic3.isHidden = false
            LocCustomPic4.isHidden = true
            LocCustomPic5.isHidden = true
            LocCustomPic6.isHidden = true
            LocCustomPic7.isHidden = true
            LocCustomPic8.isHidden = true
            LocCustomPic9.isHidden = true
            
            LocPressPic1.isHidden = false
            LocPressPic2.isHidden = false
            LocPressPic3.isHidden = false
            LocPressPic4.isHidden = true
            LocPressPic5.isHidden = true
            LocPressPic6.isHidden = true
            LocPressPic7.isHidden = true
            LocPressPic8.isHidden = true
            LocPressPic9.isHidden = true
            
            LocIcon1.isHidden = false
            LocIcon2.isHidden = true
            LocIcon3.isHidden = true
        }
        if (LoctabCount.magnitude % 3) == 1 {
            LocCustomPic1.isHidden = true
            LocCustomPic2.isHidden = true
            LocCustomPic3.isHidden = true
            LocCustomPic4.isHidden = false
            LocCustomPic5.isHidden = false
            LocCustomPic6.isHidden = false
            LocCustomPic7.isHidden = true
            LocCustomPic8.isHidden = true
            LocCustomPic9.isHidden = true
            
            LocPressPic1.isHidden = true
            LocPressPic2.isHidden = true
            LocPressPic3.isHidden = true
            LocPressPic4.isHidden = false
            LocPressPic5.isHidden = false
            LocPressPic6.isHidden = false
            LocPressPic7.isHidden = true
            LocPressPic8.isHidden = true
            LocPressPic9.isHidden = true
            
            LocIcon1.isHidden = true
            LocIcon2.isHidden = false
            LocIcon3.isHidden = true
        }
        if (LoctabCount.magnitude % 3) == 2 {
            LocCustomPic1.isHidden = true
            LocCustomPic2.isHidden = true
            LocCustomPic3.isHidden = true
            LocCustomPic4.isHidden = true
            LocCustomPic5.isHidden = true
            LocCustomPic6.isHidden = true
            LocCustomPic7.isHidden = false
            LocCustomPic8.isHidden = false
            LocCustomPic9.isHidden = false
            
            LocPressPic1.isHidden = true
            LocPressPic2.isHidden = true
            LocPressPic3.isHidden = true
            LocPressPic4.isHidden = true
            LocPressPic5.isHidden = true
            LocPressPic6.isHidden = true
            LocPressPic7.isHidden = false
            LocPressPic8.isHidden = false
            LocPressPic9.isHidden = false
            
            LocIcon1.isHidden = true
            LocIcon2.isHidden = true
            LocIcon3.isHidden = false
        }
    }

}
