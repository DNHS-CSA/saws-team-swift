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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if oStatus == true{
            orderStatus.text = "Order Complete!"
        }else{
            orderStatus.text = "Order Failed!"
        }
        // Do any additional setup after loading the view.
        

    }
    

}
