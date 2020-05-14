//
//  ViewController.swift
//  CrossyRoadTest
//
//  Created by Test on 5/12/20.
//  Copyright © 2020 AlexTitovProductions. All rights reserved.
//

import UIKit

class PerksController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet var itemTextView: UITextView!
    @IBOutlet var itemImageView: UIImageView!
    
    var itemQuantity: Int = 0
    var coins: Int = 0
    var xp: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        itemQuantity = appDelegate.itemQuantity
        coins = appDelegate.coins
        xp = appDelegate.xp
        itemTextView.text = appDelegate.itemDescription
        itemImageView.image = appDelegate.itemImage
    }

    @IBAction func plusButtonTapped(_ sender: UIButton) {
        itemQuantity = itemQuantity + 1
    }
    
    @IBAction func minusButtonTapped(_ sender: UIButton) {
        if(itemQuantity > 0) {
            itemQuantity = itemQuantity - 1
        }
    }
    
    @IBAction func purchaseButtonTapped(_ sender: UIButton) {
        appDelegate.itemQuantity = itemQuantity
    }
}

