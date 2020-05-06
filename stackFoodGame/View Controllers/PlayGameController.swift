//
//  PlayGameController.swift
//  stackFoodGame
//
//  Created by Michael Hayes on 5/6/20.
//  Copyright © 2020 Michael Hayes. All rights reserved.
//

import UIKit

class PlayGameController: UIViewController {
   
    @IBOutlet weak var ingredient: UIImageView!
    var itemGravity:CGPoint = CGPoint()
    var stopIngredient:Bool = false
    
    @IBOutlet weak var topIngredient: UIImageView!
    var topIngredientGravity:CGPoint = CGPoint()
    var stopTopIngredient:Bool = false
    
    @IBOutlet weak var ingredientCatcher: UIImageView!
    var newLocation: CGPoint = CGPoint(x: 168, y: 802)
    
    var ingredientStack: [UIImageView] = [UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView()]
    var stackIndex: Int = 1
    
    var timer:Timer? = Timer()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        itemGravity.y = 5
        topIngredientGravity.y = 0.5
        ingredientStack[stackIndex] = ingredientCatcher
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(moveItem), userInfo: nil, repeats: true)
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchBase:UITouch! = touches.first
        
        newLocation = touchBase.location(in: self.view)
        
        ingredientCatcher.center.x = newLocation.x
        
        for ingredient in ingredientStack {
            ingredient.center.x = newLocation.x
        }
    }
    @objc func moveItem(){
        if stopIngredient == false {
            ingredient.center.y = self.ingredient.center.y + itemGravity.y
        }
        if ingredientStack[stackIndex].frame.intersects(ingredient.frame){
            //timer?.invalidate()
            stopIngredient = true
            if stackIndex == 1{
                addIngredient(ingredient: ingredient )
            } else if ingredientStack[stackIndex - 1] != ingredient {
                addIngredient(ingredient: ingredient)
            }
        }
        if stopTopIngredient == false {
            topIngredient.center.y = self.ingredient.center.y + topIngredientGravity.y
        }
        if ingredientStack[stackIndex].frame.intersects(topIngredient.frame){
            //timer?.invalidate()
            stopTopIngredient = true
            if stackIndex == 1{
                addIngredient(ingredient: topIngredient )
            } else if ingredientStack[stackIndex - 1] != topIngredient {
                addIngredient(ingredient: topIngredient)
            }
        }
    }
    func addIngredient(ingredient: UIImageView!){
        ingredientStack[stackIndex] = ingredient
        stackIndex += 1
    }
    
}
