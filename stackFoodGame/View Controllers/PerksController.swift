//
//  ViewController.swift
//  CrossyRoadTest
//
//  Created by Test on 5/12/20.
//  Copyright © 2020 AlexTitovProductions. All rights reserved.
//

import UIKit
import CoreData

class PerksController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet var item1TextView: UITextView!
    @IBOutlet var item2TextView: UITextView!
    @IBOutlet var item3TextView: UITextView!
    @IBOutlet var item4TextView: UITextView!
    @IBOutlet var item5TextView: UITextView!
    @IBOutlet var item6TextView: UITextView!
    
    @IBOutlet var item1ImageView: UIImageView!
    @IBOutlet var item2ImageView: UIImageView!
    @IBOutlet var item3ImageView: UIImageView!
    @IBOutlet var item4ImageView: UIImageView!
    @IBOutlet var item5ImageView: UIImageView!
    @IBOutlet var item6ImageView: UIImageView!
    
    var imageViews : [UIImageView] = []
    var textViews : [UITextView] = []
    var coins: Int = 0;
    var xp: Int = 0;
    var perkSpeed: Int = 0
    var perkTips: Int = 0
    var perkMagnet: Int = 0
    var perkChef: Int = 0
    var perkGold: Int = 0
    var perkSecret: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        imageViews = [item1ImageView, item2ImageView, item3ImageView, item4ImageView, item5ImageView, item6ImageView]
        textViews = [item1TextView, item2TextView, item3TextView, item4TextView, item5TextView, item6TextView]
        for i in 0...5 {
            imageViews[i].image = appDelegate.perkImages[i]
            textViews[i].text = appDelegate.perkDescriptions[i]
        }
 //       itemQuantity = appDelegate.itemQuantity
    }
    
    func getData()
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
        request.returnsObjectsAsFaults = false
        do
        {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject]
            {
                coins = data.value(forKey: "coins") as! Int
                xp = data.value(forKey: "xp") as! Int
            }
            print("Data successfully fetched")
        }
        catch
        {
            print("Fetch failed")
        }
    }
    
    func saveData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let player = NSEntityDescription.entity(forEntityName: "Player", in: context)
        
        player!.setValue(coins, forKey: "coins")
        player!.setValue(xp, forKey: "xp")
        do {
            try context.save()
            print("Save successful")
            getData()
        } catch {
            print("Save failed")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // if someone is going to change segue type away from storyboard reference, keep segue identifiers the same
    switch segue.identifier ?? "" {
    case "PerksUnwind":
        print("Unwind Successful")
    default:
        print("No segue identifiers")
        }
    }

//    @IBAction func plusButtonTapped(_ sender: UIButton) {
//        itemQuantity = itemQuantity + 1
//    }
//
//    @IBAction func minusButtonTapped(_ sender: UIButton) {
//        if(itemQuantity > 0) {
//            itemQuantity = itemQuantity - 1
//        }
//    }
//
//    @IBAction func purchaseButtonTapped(_ sender: UIButton) {
//        appDelegate.itemQuantity = itemQuantity
//    }
}
