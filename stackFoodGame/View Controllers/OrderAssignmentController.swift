//
//  OrderAssignmentController.swift
//  stackFoodGame
//
//  Created by Michael Hayes on 5/6/20.
//  Copyright © 2020 Michael Hayes. All rights reserved.
//

import UIKit
import CoreData

class OrderAssignmentController: UIViewController {
    
    @IBOutlet weak var ingredientNumber1: UILabel!
    @IBOutlet weak var ingredientNumber2: UILabel!
    @IBOutlet weak var ingredientNumber3: UILabel!
    
    @IBOutlet weak var ingredient1: UIImageView!
    @IBOutlet weak var ingredient2: UIImageView!
    @IBOutlet weak var ingredient3: UIImageView!
    
    @IBOutlet weak var PlayerImage: UIImageView!
    
    var imagenumber = Int()
    
    let numberArray = (0..<3).map{ _ in Int.random(in: 1 ... 3) }
    var ingredientArray : [String] = []
    
    override func viewDidLoad() {

        // array definitions moved public to allow for segue data transfer
       
        
        var foodTypes = ingredientTypes  //just a copy without topbun
        foodTypes.removeLast()
        
        for _ in 0..<3{
            let igdt = String(foodTypes.randomElement()!)
            ingredientArray.append(igdt)
            foodTypes.remove(at: foodTypes.firstIndex(of: String(igdt))!)
        }
        
        for i in 0..<3{
            print(ingredientArray[i]+"  X"+String(numberArray[i]))
        }
        
        ingredient1.image = UIImage(named: ingredientArray[0])
        ingredient2.image = UIImage(named: ingredientArray[1])
        ingredient3.image = UIImage(named: ingredientArray[2])

        
        ingredientNumber1.text = "x\(String(numberArray[0]))"
        ingredientNumber2.text = "x\(String(numberArray[1]))"
        ingredientNumber3.text = "x\(String(numberArray[2]))"
        
        orders.append(Order(names: ingredientArray, nums: numberArray))
        
        orderGetData()
        imagenumbercheck(imagenumber: imagenumber)

        
        //verifies that there are no duplicate ingredients

        
        
        super.viewDidLoad()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func orderGetData()
    {
        let orderContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let orderRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ImageVar")
        orderRequest.returnsObjectsAsFaults = false
        do
        {
            let orderResult = try orderContext.fetch(orderRequest)
            for orderData in orderResult as! [NSManagedObject]
            {
                imagenumber = orderData.value(forKey: "imagescreen") as! Int
            }
            print("Data successfully fetched")
        }
        catch
        {
            print("Fetch failed")
        }
    }
    func imagenumbercheck(imagenumber: Int)
    {
        if imagenumber == 0 {
            PlayerImage.isHidden = true
        }
        if imagenumber == 1 {
            PlayerImage.image = UIImage(named: "boychef")
        }
        if imagenumber == 2 {
            PlayerImage.image = UIImage(named: "girlchef")
        }
        if imagenumber == 3 {
            PlayerImage.image = UIImage(named: "frog")
        }
        if imagenumber == 4 {
            PlayerImage.image = UIImage(named: "penguin")
        }
        if imagenumber == 5 {
            PlayerImage.isHidden = true
        }
        if imagenumber == 6 {
            PlayerImage.isHidden = true
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // if someone is going to change segue type away from storyboard reference, keep segue identifiers the same
        
        switch segue.identifier ?? "" {
        // cases based on segue identifiers
        case "goToPlayGame":
            guard let orderInGameUI = segue.destination as? PlayGameController else {
                fatalError("No order assignment")
            }
            orderInGameUI.orderUI.ingredientNames = ingredientArray
            orderInGameUI.orderUI.quantityOfEachIngredient = numberArray
        default:
            fatalError("No segue identifiers")
        }
    }



}
