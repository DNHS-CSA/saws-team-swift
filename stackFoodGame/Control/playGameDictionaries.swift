//
//  playGameDictionaries.swift
//  stackFoodGame
//
//  Created by Michael Hayes on 5/14/20.
//  Copyright © 2020 Michael Hayes. All rights reserved.
//

import Foundation
import UIKit
/*
 Location Spawns:
 pointL2:(x: 45.0), pointL1:(x: 125.0), cPoint:(x: 215.0), pointR1:(x: 310.0), pointR2:(x:370.0)
 */
var locationSpawns: [CGPoint] = [CGPoint(x: 45.0, y: 80.0), CGPoint(x: 125.0, y: 80.0), CGPoint(x: 215.0, y: 80.0), CGPoint(x: 310.0, y: 80.0), CGPoint(x: 370.0, y: 80.0)]

var ingredientTypes: [String] = ["cheese", "burger", "lettuce", "tomato", "onions", "mustard", "ketchup", "topBun"]

var orderIngredientType: [String] = ["cheese", "burger", "lettuce", "tomato", "onions", "mustard", "ketchup"]

var locations: [String] = ["Park", "City" ]
