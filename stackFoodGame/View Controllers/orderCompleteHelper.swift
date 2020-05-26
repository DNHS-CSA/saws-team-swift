//
//  orderCompleteHelper.swift
//  stackFoodGame
//
//  Created by Nathan on 5/25/20.
//  Copyright © 2020 Michael Hayes. All rights reserved.
//

import Foundation
import UIKit
import CoreData

let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate

func doit(){
    let player = appDelegate?.getRecordsFor(entity: "Player").first
    let level = player?.value(forKey: "level") as! Int
    player?.setValue(0, forKey: "xp")
    player?.setValue(level + 1, forKey: "level")
    appDelegate?.saveAllEntityData()
    
}
