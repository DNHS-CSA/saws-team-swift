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
    @IBOutlet weak var progressLabel: UILabel!
    
    let oStatus = true //pass in from CoreData true=fufilled false=failed
    
    var points : Int = 250
    var coins: Int = 10
    
    var mPoints : Int = 0 //just a copy of points to mutate
    
    var timer:Timer? = Timer()
    var coinTimer:Timer? = Timer()
    var levelTimer:Timer? = Timer()

    
    var xpcounter : Int = 0
    var coincounter : Int = 0
    
    var good :[String] = ["Awesome!","Nice Job!","Incredible!"]
    var bad :[String] = ["Whoops","Hmmmmm","Is it supposed to look like that?"]
    
    var levelXP : Int = 0
    
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate

    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        //reset all perks
      

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
        
        points *= Int(appDelegate!.perkGordon)
        
        print("OrderComplete> POINTS " + String(points))
        

        itemScreen.text = String(0) + " xp"
        
        let player = appDelegate?.getRecordsFor(entity: "Player").first
        
        let tcoins = player?.value(forKey: "coins") as! Int
        totalCoins.text =  ("CURRENT COINS: " + String(tcoins))
        coins *= Int(appDelegate!.perkTips)
        player?.setValue(tcoins + coins, forKey: "coins")
        
        appDelegate?.saveAllEntityData()
        
        
        createGameHistoryLog()
        
        totalCoins.text =  ("CURRENT COINS: " + String(tcoins + coins))
        
        
        
        //let tInterval :Float = 1.5/Float(points)
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(countTime), userInfo: nil, repeats: true)
        
        self.orderStatus.isHidden = false

        coinTimer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(countCoin), userInfo: nil, repeats: true)
        
        //totalCoins.text = "COINS: " + String(getCoins())
        //saveData()
        

        
        
        //let avatar = player?.value(forKey: "avatar") as! [NSManagedObject]
        //print("OrderComplete> avatar count: \(avatar.count)")
        progressImage.layer.cornerRadius = 10
        progressImage.clipsToBounds = true
        setImageSize(width: 0)
        
        progressLabel.text = ""
        
        levelXP = getLevelXP()
        
        mPoints = points // Simply copying points to mutate
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
        

        let result = doMath(input: points, x_val: xpcounter)
        self.xpcounter += 1
        

        if(result <= self.points){
            itemScreen.text = "+" + String(result) + " xp"
        }else{
            
            timer?.invalidate()

            
        }
    
        
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
        
        guard points != 0 else { //acts wierd when hits 0; put in guard to simplify
            levelTimer?.invalidate()
            return
        }
        
        var player = appDelegate?.getRecordsFor(entity: "Player").first

        let levelXP = getLevelXP()
        
        let sPoints = player?.value(forKey: "xp") as! Int
        
        
        let result = doMath(input: mPoints, x_val: levelc) + sPoints
        levelc += 1 //incriment x val
        
        let pixelSize = 315.0/Float(levelXP) //pixels per point
        let pixelsG = Int(Float(result) * pixelSize) // pixels to set image to grow to
        setImageSize(width: pixelsG)
        
        
        if result == levelXP {
            //increment level val
            mPoints = mPoints + sPoints - levelXP //updating points to fit new level
            
            
            let k = player?.value(forKey: "level") as! Int
            player?.setValue(k + 1, forKey: "level") //simple adding 1 to level
            player?.setValue(0, forKey: "xp")//resetting previous points to 0
            appDelegate?.saveAllEntityData()
            
            
            levelc = 0 //resetting counter so it can count up again
            
            print("OrderComplete> NEW LEVEL")
            
            
        }
        
        if result == mPoints { // only activated when it is finished
            player?.setValue(mPoints, forKey: "xp") //setting the starting xp value for next play
            appDelegate?.saveAllEntityData()
            
            print("OrderComplete> DONE")
            
            self.progressLabel.text = "\(levelXP-mPoints) points until level \(player?.value(forKey: "level") as! Int + 1)!"
            
            print("lxp \(levelXP) || spoints \(sPoints)")

            
            levelTimer?.invalidate()
        }
        
        
        
        
    }
    
    
    
    
    
    func setImageSize(width: Int){
        var frame : CGRect = self.progressImage.frame
        frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: CGFloat(width), height: frame.height)
        self.progressImage.frame = frame
    }
    
    
    
    
    func getLevelXP() -> Int {
        let player = appDelegate?.getRecordsFor(entity: "Player").first
        let levelNum = player?.value(forKey: "level") as! Int
        
        let step1 = pow(1.5, Double(levelNum)) * 300
        
        return Int(step1)
    }
    
    
    
    
    func createGameHistoryLog(){
        let managedObjectContext = appDelegate?.coreDataManager.managedObjectContext
        // fetches player entity and gets current avatar and location from respective relationships to player
        let player = appDelegate?.getRecordsFor(entity: "Player").first
        //let avatar = player?.value(forKey: "avatar") // fetch relationship data
        //let location = player?.value(forKey: "location") ?? "No location" // fetch relationship data
        //let totalCoins = player?.value(forKey: "coins") // fetch relationship data
        // creates a new row in gamHistory and sets values of avatar and location into relatioship and coins and date into normal attribute
        let newGameHistoryEntry = appDelegate?.createRecordForEntity("GameHistory", inManagedObjectContext: managedObjectContext!)
        newGameHistoryEntry?.setValue(player, forKey: "player")
        //newGameHistoryEntry?.setValue(avatar, forKey: "avatar") // set data in relationship
        //newGameHistoryEntry?.setValue(location, forKey: "location") // set data in relationship
        newGameHistoryEntry?.setValue(coins, forKey: "coins") // set data in attribute
        
        let endOfRoundTimeStamp = Date() // takes current timestamp once order is complete
        newGameHistoryEntry?.setValue(endOfRoundTimeStamp, forKey: "date")
        
        appDelegate?.saveAllEntityData()
        
        
    }

    @IBAction func nextGameButtonTapped(_ sender: UIButton) {
        appDelegate?.perkSpeed = 1.0
              appDelegate?.perkTips = 1.0
              appDelegate?.perkChef = 0.0
              appDelegate?.perkGold = 0.0
              appDelegate?.perkGordon = 1.0
              appDelegate?.perkSecret = 0.0
    }
    
    @IBAction func mainMenuButtonTapped(_ sender: UIButton) {
        appDelegate?.perkSpeed = 1.0
              appDelegate?.perkTips = 1.0
              appDelegate?.perkChef = 0.0
              appDelegate?.perkGold = 0.0
              appDelegate?.perkGordon = 1.0
              appDelegate?.perkSecret = 0.0
    }
}
