//
//  OrderCompleteController.swift
//  stackFoodGame
//
//  Created by Michael Hayes on 5/6/20.
//  Copyright © 2020 Michael Hayes. All rights reserved.
//

import UIKit
import CoreData

class OrderCompleteController: UIViewController {

    @IBOutlet weak var itemScreen: UILabel!
    @IBOutlet weak var newGame: UIButton!
    @IBOutlet weak var mainMenu: UIButton!
    @IBOutlet weak var orderStatus: UILabel!
    @IBOutlet weak var totalCoins: UILabel!
    
    let oStatus = true //pass in from CoreData true=fufilled false=failed
    
    var points : Int = 100
    var coins: Int = 10
    
    var timer:Timer? = Timer()
    
    var counter : Int = 0
    
    var good :[String] = ["Awesome!","Nice Job!","Incredible!"]
    var bad :[String] = ["Whoops","Hmmmmm","Is it supposed to look like that?"]
    
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate

    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        points = 100 //start with 50 points
        var idealPoints = 100 //ideal points
        
        var myBurger = orders.last!.curBurger //copy of current burger
        
        for(key, value) in orders.last!.order{ //looping over key pairs,locating ingredients, assigning points
            
            for _ in (0..<value){
                if myBurger.contains(key){
                    myBurger.remove(at: myBurger.firstIndex(of: String(key))!)
                    points += 40
                    print("OrderComplete> found " + key)
                    coins += 50
                }else{
                    points -= 40
                    print("OrderComplete> didnt find " + key)
                }
                idealPoints += 40
            }
        }
        
        points -= myBurger.count*20 //subtracting points for excess ingredients
        if(points<0){points=0}
        
        if(Double(points) >= Double(idealPoints) * 0.65){
            orderStatus.text = good.randomElement()
        }else{
            orderStatus.text = bad.randomElement()
        }
        orderStatus.isHidden = true
        
        print("OrderComplete> Ideal Points, " + String(idealPoints))
        
        
        print("OrderComplete> POINTS " + String(points))
        

        itemScreen.text = String(0) + " xp"
        
        let player = appDelegate?.getRecordsFor(entity: "Player").first
        
        let tcoins = player?.value(forKey: "coins") as! Int
        totalCoins.text =  ("CURRENT COINS: " + String(tcoins))
        
        
        
        //let tInterval :Float = 1.5/Float(points)
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(countTime), userInfo: nil, repeats: true)
        
        self.orderStatus.isHidden = false
        //totalCoins.text = "COINS: " + String(getCoins())
        //saveData()
        
        player?.setValue(tcoins + coins, forKey: "coins")
        appDelegate?.saveAllEntityData()
        totalCoins.text =  ("CURRENT COINS: " + String(tcoins + coins))

        


    }
    
    
    
    
    
    @objc func countTime(){
        
        let ppp = Double(points) * 1.003
        
        let step1 = pow(2.71828, -0.00285 * Double(self.counter))
        let step2 = ppp * Double(step1)
        let step3 = ppp - Double(step2)
        
        //print(String(self.points) + "  " + String(step3))
        self.counter += 1
        //if()
        
        if(Int(step3) <= self.points){
            itemScreen.text = "+" + String(Int(step3)) + " xp"
        }else{
            
            timer?.invalidate()
        }
        
        
        /*
        let cpoints = Int(itemScreen.text!)!
        print(String(self.points) + "  " + String(cpoints))
        if(self.points > cpoints){
            itemScreen.text = String(cpoints+1)
        }else{
            //timer?.invalidate()
        }*/
        
    }


}
