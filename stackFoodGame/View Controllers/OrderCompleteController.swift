//
//  OrderCompleteController.swift
//  stackFoodGame
//
//  Created by Michael Hayes on 5/6/20.
//  Copyright © 2020 Michael Hayes. All rights reserved.
//

import UIKit
import CoreData

class OrderCompleteController: UIViewController{

    

    @IBOutlet weak var itemScreen: UILabel!
    @IBOutlet weak var newGame: UIButton!
    @IBOutlet weak var mainMenu: UIButton!
    @IBOutlet weak var orderStatus: UILabel!
    @IBOutlet weak var totalCoins: UILabel!
    @IBOutlet weak var coinScreen: UILabel!
    @IBOutlet weak var progressImage: UIImageView!
    
    let oStatus = true //pass in from CoreData true=fufilled false=failed
    
    var points : Int = 100
    var coins: Int = 10
    
    var timer:Timer? = Timer()
    var coinTimer:Timer? = Timer()
    var levelTimer:Timer? = Timer()

    
    var xpcounter : Int = 0
    var coincounter : Int = 0
    
    var good :[String] = ["Awesome!","Nice Job!","Incredible!"]
    var bad :[String] = ["Whoops","Hmmmmm","Is it supposed to look like that?"]
    
    var levelXP : Int = 300
    
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
        
        if(Double(points)  >= Double(idealPoints) * 0.65){
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

        coinTimer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(countCoin), userInfo: nil, repeats: true)
        
        //totalCoins.text = "COINS: " + String(getCoins())
        //saveData()
        
        player?.setValue(tcoins + coins, forKey: "coins")
        appDelegate?.saveAllEntityData()
        totalCoins.text =  ("CURRENT COINS: " + String(tcoins + coins))
        
        
        //let avatar = player?.value(forKey: "avatar") as! [NSManagedObject]
        //print("OrderComplete> avatar count: \(avatar.count)")
        progressImage.layer.cornerRadius = 10
        progressImage.clipsToBounds = true
        setImageSize(width: 0)
        levelTimer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(countLevel), userInfo: nil, repeats: true)


    }
    
    
    func doMath(input: Int, x_val: Int) -> Int {
        
        let ppp = Double(input) * 1.003
        let step1 = pow(2.71828, -0.00285 * Double(x_val))
        let step2 = ppp * Double(step1)
        let step3 = ppp - Double(step2)
        
        return Int(step3)
    }
    
    
    
    @objc func countTime(){
        

        
        //print(String(self.points) + "  " + String(step3))
        //if()
        let result = doMath(input: points, x_val: xpcounter)
        self.xpcounter += 1
        

        if(result <= self.points){
            itemScreen.text = "+" + String(result) + " xp"
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
    
    @objc func countCoin(){
        
        let result = doMath(input: coins, x_val: coincounter)
        self.coincounter += 1

        if(result <= self.coins){
            coinScreen.text = "+" + String(result) + "$"
        }else{
            coinTimer?.invalidate()
            
        }
    }
    
    var levelc : Int = 0
    
    @objc func countLevel(){
        let pixels : Float = Float((315 * self.points)/self.levelXP)
        //print(pixels)
        
        let result = doMath(input: Int(pixels), x_val: levelc)
        levelc += 1
        
        if result <= Int(pixels) {
            setImageSize(width: result)
        }else{
            levelTimer?.invalidate()
        }
        
    }
    
    func setImageSize(width: Int){
        var frame : CGRect = self.progressImage.frame
        frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: CGFloat(width), height: frame.height)
        self.progressImage.frame = frame
    }

    
}
