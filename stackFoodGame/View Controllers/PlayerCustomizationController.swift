//
//  ViewController.swift
//  stackFoodGame
//
//  Created by Nakul Nandhakumar on 5/7/20.
//  Copyright © 2020 Nakul Nandhakumar. All rights reserved.
//

import UIKit
import CoreData


class PlayerCustomizationController: UIViewController {
    
    @IBOutlet weak var CustomPic1: UIImageView!
    @IBOutlet weak var CustomPic2: UIImageView!
    @IBOutlet weak var CustomPic3: UIImageView!
    @IBOutlet weak var CustomPic4: UIImageView!
    @IBOutlet weak var CustomPic5: UIImageView!
    @IBOutlet weak var CustomPic6: UIImageView!
    
    @IBOutlet weak var Pic1: UIImageView!
    @IBOutlet weak var Pic2: UIImageView!
    @IBOutlet weak var Pic3: UIImageView!
    @IBOutlet weak var Pic4: UIImageView!
    @IBOutlet weak var Pic5: UIImageView!
    @IBOutlet weak var Pic6: UIImageView!
    
    @IBOutlet weak var PressPic1: UIButton!
    @IBOutlet weak var PressPic2: UIButton!
    @IBOutlet weak var PressPic3: UIButton!
    @IBOutlet weak var PressPic4: UIButton!
    @IBOutlet weak var PressPic5: UIButton!
    @IBOutlet weak var PressPic6: UIButton!
    
    var count = Int()
    var imagescreen = Int()
    
    override func viewDidLoad() {
        getData()
        imagechecker(imagescreen: imagescreen)
        countchecker(count: count)
        super.viewDidLoad()
    }
    
    @IBAction func PressPic1(_ sender: Any)
    {
        imagescreen = 1
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let Count = NSEntityDescription.entity(forEntityName: "ImageVar", in: context)
        let newCount = NSManagedObject(entity: Count!, insertInto:  context)
        
        newCount.setValue(imagescreen, forKey: "imagescreen")
        do {
            try context.save()
            print("Save successful")
            getData()
        } catch {
            print("Save failed")
        }
        imagechecker(imagescreen: imagescreen)
    }
    
    @IBAction func PressPic2(_ sender: Any)
    {
        imagescreen = 2
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
         
         let Count = NSEntityDescription.entity(forEntityName: "ImageVar", in: context)
         let newCount = NSManagedObject(entity: Count!, insertInto:  context)
         
         newCount.setValue(imagescreen, forKey: "imagescreen")
         do {
             try context.save()
             print("Save successful")
             getData()
         } catch {
             print("Save failed")
         }
        imagechecker(imagescreen: imagescreen)
    }
    
    @IBAction func PressPic3(_ sender: Any)
    {
        imagescreen = 3
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
         
         let Count = NSEntityDescription.entity(forEntityName: "ImageVar", in: context)
         let newCount = NSManagedObject(entity: Count!, insertInto:  context)
         
         newCount.setValue(imagescreen, forKey: "imagescreen")
         do {
             try context.save()
             print("Save successful")
             getData()
         } catch {
             print("Save failed")
         }
        imagechecker(imagescreen: imagescreen)
    }
    
    @IBAction func PressPic4(_ sender: Any)
    {
        imagescreen = 4
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
         
         let Count = NSEntityDescription.entity(forEntityName: "ImageVar", in: context)
         let newCount = NSManagedObject(entity: Count!, insertInto:  context)
         
         newCount.setValue(imagescreen, forKey: "imagescreen")
         do {
             try context.save()
             print("Save successful")
             getData()
         } catch {
             print("Save failed")
         }
        imagechecker(imagescreen: imagescreen)
    }
    
    @IBAction func PressPic5(_ sender: Any)
    {
        imagescreen = 5
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
         
         let Count = NSEntityDescription.entity(forEntityName: "ImageVar", in: context)
         let newCount = NSManagedObject(entity: Count!, insertInto:  context)
         
         newCount.setValue(imagescreen, forKey: "imagescreen")
         do {
             try context.save()
             print("Save successful")
             getData()
         } catch {
             print("Save failed")
         }
        imagechecker(imagescreen: imagescreen)
    }
    
    @IBAction func PressPic6(_ sender: Any)
    {
        imagescreen = 6
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
         
         let Count = NSEntityDescription.entity(forEntityName: "ImageVar", in: context)
         let newCount = NSManagedObject(entity: Count!, insertInto:  context)
         
         newCount.setValue(imagescreen, forKey: "imagescreen")
         do {
             try context.save()
             print("Save successful")
             getData()
         } catch {
             print("Save failed")
         }
        imagechecker(imagescreen: imagescreen)
    }
    
    @IBAction func NextArrow(_ sender: Any)
    {
        count += 1
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let Count = NSEntityDescription.entity(forEntityName: "ImageVar", in: context)
        let newCount = NSManagedObject(entity: Count!, insertInto:  context)
        
        newCount.setValue(count, forKey: "count")
        do {
            try context.save()
            print("Save successful")
            getData()
        } catch {
            print("Save failed")
        }
        countchecker(count: count)
    }
    
    @IBAction func PreviousArrow(_ sender: Any)
    {
        count -= 1
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let Count = NSEntityDescription.entity(forEntityName: "ImageVar", in: context)
        let newCount = NSManagedObject(entity: Count!, insertInto:  context)
        
        newCount.setValue(count, forKey: "count")
        do {
            try context.save()
            print("Save successful")
            getData()
        } catch {
            print("Save failed")
        }
        countchecker(count: count)
    }

    func getData()
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ImageVar")
        request.returnsObjectsAsFaults = false
        do
        {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject]
            {
                count = data.value(forKey: "count") as! Int
                imagescreen = data.value(forKey: "imagescreen") as! Int
            }
        }
        catch
        {
            print("Fetch failed")
        }
    }
    
    func imagechecker(imagescreen: Int)
    {
        if imagescreen == 0 {
            Pic1.isHidden = true
            Pic2.isHidden = true
            Pic3.isHidden = true
            Pic4.isHidden = true
            Pic5.isHidden = true
            Pic6.isHidden = true
        }
        if imagescreen == 1 {
            Pic1.isHidden = false
            Pic2.isHidden = true
            Pic3.isHidden = true
            Pic4.isHidden = true
            Pic5.isHidden = true
            Pic6.isHidden = true
        }
        if imagescreen == 2 {
            Pic1.isHidden = true
            Pic2.isHidden = false
            Pic3.isHidden = true
            Pic4.isHidden = true
            Pic5.isHidden = true
            Pic6.isHidden = true
        }
        if imagescreen == 3 {
            Pic1.isHidden = true
            Pic2.isHidden = true
            Pic3.isHidden = false
            Pic4.isHidden = true
            Pic5.isHidden = true
            Pic6.isHidden = true
        }
        if imagescreen == 4 {
            Pic1.isHidden = true
            Pic2.isHidden = true
            Pic3.isHidden = true
            Pic4.isHidden = false
            Pic5.isHidden = true
            Pic6.isHidden = true
        }
        if imagescreen == 5 {
            Pic1.isHidden = true
            Pic2.isHidden = true
            Pic3.isHidden = true
            Pic4.isHidden = true
            Pic5.isHidden = false
            Pic6.isHidden = true
        }
        if imagescreen == 6 {
            Pic1.isHidden = true
            Pic2.isHidden = true
            Pic3.isHidden = true
            Pic4.isHidden = true
            Pic5.isHidden = true
            Pic6.isHidden = false
        }
    }
    
    func countchecker(count: Int)
    {
        if (count.magnitude % 2) == 0 {
            CustomPic1.isHidden = false
            CustomPic2.isHidden = false
            CustomPic3.isHidden = false
            CustomPic4.isHidden = true
            CustomPic5.isHidden = true
            CustomPic6.isHidden = true
            
            PressPic1.isHidden = false
            PressPic2.isHidden = false
            PressPic3.isHidden = false
            PressPic4.isHidden = true
            PressPic5.isHidden = true
            PressPic6.isHidden = true
        }
        if (count.magnitude % 2) == 1 {
            CustomPic1.isHidden = true
            CustomPic2.isHidden = true
            CustomPic3.isHidden = true
            CustomPic4.isHidden = false
            CustomPic5.isHidden = false
            CustomPic6.isHidden = false
            
            PressPic1.isHidden = true
            PressPic2.isHidden = true
            PressPic3.isHidden = true
            PressPic4.isHidden = false
            PressPic5.isHidden = false
            PressPic6.isHidden = false
        }
    }

}

