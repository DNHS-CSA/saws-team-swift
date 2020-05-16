//
//  OrderCompleteController.swift
//  stackFoodGame
//
//  Created by Michael Hayes on 5/6/20.
//  Copyright © 2020 Michael Hayes. All rights reserved.
//

import UIKit

class OrderCompleteController: UIViewController {

    @IBOutlet weak var itemScreen: UILabel!
    @IBOutlet weak var newGame: UIButton!
    @IBOutlet weak var mainMenu: UIButton!
    @IBOutlet weak var orderStatus: UILabel!
    
    let oStatus = true //pass in from CoreData true=fufilled false=failed
    
    var points : Int = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        points = 50 //start with 50 points
        
        var myBurger = orders.last!.curBurger //copy of current burger
        
        for(key, value) in orders.last!.order{ //looping over key pairs,locating ingredients, assigning points
            
            for _ in (0..<value){
                if myBurger.contains(key){
                    myBurger.remove(at: myBurger.firstIndex(of: String(key))!)
                    points += 20
                    print("found " + key)
                }else{
                    points -= 20
                    print("didnt find " + key)
                }
            }
        }
        
        points -= myBurger.count*10 //subtracting points for excess ingredients
        
        print(String(points))
        

        if oStatus == true{
            orderStatus.text = "Order Complete!"
        }else{
            orderStatus.text = "Order Failed!"
        }
        // Do any additional setup after loading the view.
        
        for o in orders.last!.curBurger{
            print(o)
        }

    }
    

}
