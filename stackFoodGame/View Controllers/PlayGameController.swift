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
    var stackIndex: Int = 0
    
    var timer:Timer? = Timer()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        itemGravity.y = 5
        topIngredientGravity.y = 2.5
        ingredientStack[stackIndex] = ingredientCatcher
        timer = Timer.scheduledTimer(timeInterval: 0.025, target: self, selector: #selector(moveItem), userInfo: nil, repeats: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /*
         
        timer = Timer.scheduledTimer(timeInterval: 0.025, target: self, selector: #selector(moveItem), userInfo: nil, repeats: true)
         
         moved the timer from here to the move did load. If its here everytime the user presses the screen it will start an other timer essentially doubling its speed by moving it to the viewdidLoad() there is only 1 timer running in a game(keeping speeds the same regardless of touch)
         
         */
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
        var localStackIndex = stackIndex
        if stackIndex != 0 {
            localStackIndex = stackIndex - 1
        }
        if stopIngredient == false {
            ingredient.center.y = self.ingredient.center.y + itemGravity.y
        }
        if ingredientStack[localStackIndex].frame.intersects(ingredient.frame){
            stopIngredient = true
            if stackIndex == 0 {
                stackIndex += 1
                addIngredient(ingredient: ingredient )
            } else if stackIndex - 1 != 0 && stopIngredient == false {
                addIngredient(ingredient: ingredient)
            }
            
            stopIngredient = true
        }
        if stopTopIngredient == false {
            topIngredient.center.y = self.topIngredient.center.y + topIngredientGravity.y
        }
        
        if ingredientStack[localStackIndex].frame.intersects(topIngredient.frame){
            if stackIndex == 0 {
                stackIndex += 1
                addIngredient(ingredient: topIngredient)
            } else if stackIndex - 1 != 0 && stopTopIngredient == false {
                addIngredient(ingredient: topIngredient)
            }
            
            stopTopIngredient = true
        }
    }
    func addIngredient(ingredient: UIImageView!){
        print(stackIndex)
        ingredientStack[stackIndex] = ingredient
        stackIndex += 1
    }
    
}
