//
//  ViewController.swift
//  stackFoodGame
//
//  Created by Michael Hayes on 5/6/20.
//  Copyright © 2020 Michael Hayes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    
    @IBOutlet weak var Background: UIImageView!
    
    override func viewDidLoad() {
        setBackground()
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        // 
    }
    
    @IBAction func unwindToMainMenu(_ unwindSegue: UIStoryboardSegue) {
    }
    
    func setBackground() -> Void {
        let players = appDelegate?.getRecordsFor(entity: "Player").first
        let location = players?.value(forKey: "location") as! NSObject
        let backgroundName = location.value(forKey: "lociconName") as! String
        Background.image = UIImage(named: backgroundName)
    }
}

