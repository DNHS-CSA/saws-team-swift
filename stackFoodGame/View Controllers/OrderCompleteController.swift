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
    
    var points : Int = 100
    
    var timer:Timer? = Timer()
    
    var counter : Int = 0
    
    var good :[String] = ["Awesome!","Nice Job!","Incredible!"]
    var bad :[String] = ["Whoops","Hmmmmm","Is it supposed to look like that?"]

    
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
                    print("found " + key)
                }else{
                    points -= 40
                    print("didnt find " + key)
                }
                idealPoints += 40
            }
        }
        
        points -= myBurger.count*20 //subtracting points for excess ingredients
        if(points<0){points=0}
        
        if(points >= idealPoints-80){
            orderStatus.text = good.randomElement()
        }else{
            orderStatus.text = bad.randomElement()
        }
        orderStatus.isHidden = true
        print(String(idealPoints))
        
        
        
        print("POINTS " + String(points))
        

        itemScreen.text = String(0) + " xp"
        
        /*
        if oStatus == true{
            orderStatus.text = "Order Complete!"
        }else{
            orderStatus.text = "Order Failed!"
        }
        // Do any additional setup after loading the view.
        
        for o in orders.last!.curBurger{
            print(o)
        }*/
        
        
        
        let tInterval :Float = 1.5/Float(points)
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(countTime), userInfo: nil, repeats: true)
        
        self.orderStatus.isHidden = false
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
            itemScreen.text = String(Int(step3)) + " xp"
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
