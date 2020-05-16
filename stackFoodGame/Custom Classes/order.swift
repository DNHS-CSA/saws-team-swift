//
//  order.swift
//  stackFoodGame
//
//  Created by Nathan on 5/15/20.
//  Copyright © 2020 Michael Hayes. All rights reserved.
//

import Foundation
import UIKit

class Order {
    
    var imgNames: [String]
    var order: [String:Int] = [:]
    
    init(imgNames:[String], order:[String:Int]) {
        self.imgNames = imgNames
        self.order = order
    }
    
    func addIngredient(name:String){
        
    }
    
}

var orders : [Order] = []
