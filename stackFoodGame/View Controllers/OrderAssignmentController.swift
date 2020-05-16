//
//  OrderAssignmentController.swift
//  stackFoodGame
//
//  Created by Michael Hayes on 5/6/20.
//  Copyright © 2020 Michael Hayes. All rights reserved.
//

import UIKit

class OrderAssignmentController: UIViewController {
    
    @IBOutlet weak var ingredientNumber1: UILabel!
    @IBOutlet weak var ingredientNumber2: UILabel!
    @IBOutlet weak var ingredientNumber3: UILabel!
    @IBOutlet weak var ingredient1: UIImageView!
    @IBOutlet weak var ingredient2: UIImageView!
    @IBOutlet weak var ingredient3: UIImageView!
    
    override func viewDidLoad() {

        let numberArray = (0..<3).map{ _ in Int.random(in: 1 ... 3) }
        var ingredientArray : [String] = []
        
        var foodTypes = ingredientTypes  //just a copy without topbun
        foodTypes.removeLast()
        
        for _ in 0..<3{
            let igdt = String(foodTypes.randomElement()!)
            ingredientArray.append(igdt)
            foodTypes.remove(at: foodTypes.firstIndex(of: String(igdt))!)
        }
        
        for s in ingredientArray{
            print(s)
        }
        
        ingredient1.image = UIImage(named: ingredientArray[0])
        ingredient2.image = UIImage(named: ingredientArray[1])
        ingredient3.image = UIImage(named: ingredientArray[2])

        
        ingredientNumber1.text = "x\(String(numberArray[0]))"
        ingredientNumber2.text = "x\(String(numberArray[1]))"
        ingredientNumber3.text = "x\(String(numberArray[2]))"
        
        orders.append(Order(names: ingredientArray, nums: numberArray))
        
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

}
