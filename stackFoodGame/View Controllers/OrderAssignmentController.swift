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
        let ingredientAmount1 = Int.random(in: 1...3)
        let ingredientAmount2 = Int.random(in: 1...3)
        let ingredientAmount3 = Int.random(in: 1...3)
        ingredientNumber1.text = "x\(String(ingredientAmount1))"
        ingredientNumber2.text = "x\(String(ingredientAmount2))"
        ingredientNumber3.text = "x\(String(ingredientAmount3))"
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
