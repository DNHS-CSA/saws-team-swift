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
    
    @IBOutlet var item1PriceLabel: UILabel!
    @IBOutlet var item2PriceLabel: UILabel!
    @IBOutlet var item3PriceLabel: UILabel!
    @IBOutlet var item4PriceLabel: UILabel!
    @IBOutlet var item5PriceLabel: UILabel!
    @IBOutlet var item6PriceLabel: UILabel!
    
    @IBOutlet var item1AmountLabel: UILabel!
    @IBOutlet var item2AmountLabel: UILabel!
    @IBOutlet var item3AmountLabel: UILabel!
    @IBOutlet var item4AmountLabel: UILabel!
    @IBOutlet var item5AmountLabel: UILabel!
    @IBOutlet var item6AmountLabel: UILabel!
    
    @IBOutlet var xpLabel: UILabel!
    @IBOutlet var coinsLabel: UILabel!
    
   private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var playerArray : [Player] = [Player]()
    var player : Player?
    var imageViews : [UIImageView] = []
    var textViews : [UITextView] = []
    var coins: Int = 1000;
    var xp: Int = 2020;
    var item1c = 0, item2c = 0, item3c = 0, item4c = 0, item5c = 0, item6c = 0 //c = counter
    var item1p = 50, item2p = 25, item3p = 70, item4p = 100, item5p = 300, item6p = 500 //p = price
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        do {
            playerArray = try context.fetch(Player.fetchRequest())
            print("Size of fetched player array = ", playerArray.count)
            player = playerArray[0]
            coins = Int(player!.coins)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        self.navigationController?.isNavigationBarHidden = true
        imageViews = [item1ImageView, item2ImageView, item3ImageView, item4ImageView, item5ImageView, item6ImageView]
        textViews = [item1TextView, item2TextView, item3TextView, item4TextView, item5TextView, item6TextView]
        for i in 0...5 {
            imageViews[i].image = appDelegate.perkImages[i]
            textViews[i].text = appDelegate.perkDescriptions[i]
        }
        item1PriceLabel.text = "$" + String(item1p)
        item2PriceLabel.text = "$" + String(item2p)
        item3PriceLabel.text = "$" + String(item3p)
        item4PriceLabel.text = "$" + String(item4p)
        item5PriceLabel.text = "$" + String(item5p)
        item6PriceLabel.text = "$" + String(item6p)

        coinsLabel.text = String(coins)
        xpLabel.text = String(xp)
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
    
    @IBAction func item1PlusButtonTapped(_ sender: UIButton) {
        item1c += 1
        item1AmountLabel.text = String(item1c)
    }
    
    @IBAction func item2PlusButtonTapped(_ sender: UIButton) {
        item2c += 1
        item2AmountLabel.text = String(item2c)
    }
    
    @IBAction func item3PlusButtonTapped(_ sender: UIButton) {
        item3c += 1
        item3AmountLabel.text = String(item3c)
    }
    
    @IBAction func item4PlusButtonTapped(_ sender: UIButton) {
        item4c += 1
        item4AmountLabel.text = String(item4c)
    }
    
    @IBAction func item5PlusButtonTapped(_ sender: UIButton) {
        item5c += 1
        item5AmountLabel.text = String(item5c)
    }
    
    @IBAction func item6PlusButtonTapped(_ sender: UIButton) {
        item6c += 1
        item6AmountLabel.text = String(item6c)
    }
    
    @IBAction func item1MinusButtonTapped(_ sender: UIButton) {
        if(item1c > 0) {
            item1c -= 1
            item1AmountLabel.text = String(item1c)
        }
    }
    
    @IBAction func item2MinusButtonTapped(_ sender: UIButton) {
        if(item2c > 0) {
            item2c -= 1
            item2AmountLabel.text = String(item2c)
        }
    }
    
    @IBAction func item3MinusButtonTapped(_ sender: UIButton) {
        if(item3c > 0) {
            item3c -= 1
            item3AmountLabel.text = String(item3c)
        }
    }
    
    @IBAction func item4MinusButtonTapped(_ sender: UIButton) {
        if(item4c > 0) {
            item4c -= 1
            item4AmountLabel.text = String(item4c)
        }
    }
    
    @IBAction func item5MinusButtonTapped(_ sender: UIButton) {
        if(item5c > 0) {
            item5c -= 1
            item5AmountLabel.text = String(item5c)
        }
    }
    
    @IBAction func item6MinusButtonTapped(_ sender: UIButton) {
        if(item6c > 0) {
            item6c -= 1
            item6AmountLabel.text = String(item6c)
        }
    }
    // Perks can only be purchased once. Once the transaction is complete, the player is taken to the "playGame" storyboard
    @IBAction func purchaseButtonTapped(_ sender: UIButton) {
        let totalCost: Int = (item1p * item1c) + (item2p * item2c) + (item3p * item3c) + (item4p * item4c) + (item5p * item5c) + (item6p * item6c)
        if totalCost <= coins {
            coins -= totalCost
            coinsLabel.text = String(coins)
            // Incert segue to "playGame" SB
        } else {
            print("You do not have the facilities for that big man")
        }
        
    }
}
