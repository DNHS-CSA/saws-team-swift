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

    @IBOutlet var item1TextView: UITextView!
    @IBOutlet var item2TextView: UITextView!
    @IBOutlet var item3TextView: UITextView!
    @IBOutlet var item4TextView: UITextView!
    @IBOutlet var item5TextView: UITextView!
    @IBOutlet var item6TextView: UITextView!
    
    @IBOutlet var item1ImageView: UIImageView!
    @IBOutlet var item2ImageView: UIImageView!
    @IBOutlet var item3ImageView: UIImageView!
    @IBOutlet var item4ImageView: UIImageView!
    @IBOutlet var item5ImageView: UIImageView!
    @IBOutlet var item6ImageView: UIImageView!
    
    var imageViews : [UIImageView] = []
    var textViews : [UITextView] = []

    var itemQuantity: Int = 0
    var coins: Int = 0
    var xp: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        imageViews = [item1ImageView, item2ImageView, item3ImageView, item4ImageView, item5ImageView, item6ImageView]
        textViews = [item1TextView, item2TextView, item3TextView, item4TextView, item5TextView, item6TextView]
        for i in 0...5 {
            imageViews[i].image = appDelegate.perkImages[i]
            textViews[i].text = appDelegate.perkDescriptions[i]
        }
        itemQuantity = appDelegate.itemQuantity
        coins = appDelegate.coins
        xp = appDelegate.xp
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

