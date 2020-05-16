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
    var curBurger: [String] = []
    var order: [String:Int] = [:]

    
    
    init(names:[String], nums:[Int]) {
        self.imgNames = names
        self.fillOrder(names: names, nums: nums)
    }
    
    func fillOrder(names:[String],nums:[Int]){
        for i in 0..<3{
            self.order[names[i]] = nums[i]
        }
    }
    
    func addIngredient(name:String){
        curBurger.append(name)
    }
    
}

var orders : [Order] = []
