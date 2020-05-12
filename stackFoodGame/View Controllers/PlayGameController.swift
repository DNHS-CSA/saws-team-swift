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
    
    var ingredientStack: [Ingredient] = []
    var stackIndex: Int = 0
    var ingredientSize = CGSize(width: 80.0, height: 60.0)
    
    var entitiesInView: [Ingredient] = []
    
    var timer:Timer? = Timer()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        ingredientStack.append(Ingredient(name: String(), image: UIImageView(), inStack: false, gravity: CGPoint(x: 0.0, y: 0.0)))
        ingredientStack[stackIndex].image = ingredientCatcher // array of UIImageViews that fills up based on what is in the stack- first element is the base (ingredientCatcher)
        ingredientStack[stackIndex].name = "ingredientCatcher"
        
        timer = Timer.scheduledTimer(timeInterval: 0.025, target: self, selector: #selector(moveItem), userInfo: nil, repeats: true)
        spawnIngredients(ingredientType: "burger", ingredientGravity: CGPoint(x: 0.0, y: 5.0), location: CGPoint(x: 80.0, y: 60.0))
        spawnIngredients(ingredientType: "tomato", ingredientGravity: CGPoint(x: 0.0, y: 2.5), location: CGPoint(x: 230.0, y: 90.0))
        //entitiesInView.append(Ingredient(name: String(), image: ingredient, inStack: false, gravity: CGPoint(x: 0.0, y: 5.0)))
        //entitiesInView.append(Ingredient(name: String(), image: topIngredient, inStack: false, gravity: CGPoint(x: 0.0, y: 2.5)))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /*
        
        timer = Timer.scheduledTimer(timeInterval: 0.025, target: self, selector: #selector(moveItem), userInfo: nil, repeats: true)
         
         moved the timer from here to the move did load. If its here everytime the user presses the screen it will start an other timer essentially doubling its speed by moving it to the viewdidLoad() there is only 1 timer running in a game(keeping speeds the same regardless of touch)
         
         */
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchBase:UITouch! = touches.first
        /*
         Base is first move
         */
        newLocation = touchBase.location(in: self.view)
        
        /*
        Code below explains what it happening to each item, original code for movement of base (commented out because the ingredientCatcher UIImageView is in the ingredientStack array so the movement is now performed in for loop below)
         
         ingredientCatcher.center.x = newLocation.x
         */
        
        /*
         For loop method
         Cycles through all of the items in the array and moves according to where the touch is in the UIView. Elements in the array are only added when they are in the stack, thus for loop moves the whole stack on the screen
         */
        for ingredient in ingredientStack {
            ingredient.image.center.x = newLocation.x
        }
    }
    @objc func moveItem(){
        var localStackIndex = stackIndex
        // addIngredient func always sets up array for a new element, thus if the stack has something in it, to do the tests below, it must look at the previous element
        if stackIndex != 0 {
            localStackIndex = stackIndex - 1
        }
        /*
        Method explanation
        1. Cycles through all of the entities in the view
        2. If the stack of food (top item only) intersects with the falling ingredient it will stop the falling ingredient from moving
        3. If there is no other items in stack other than the base (array position zero), then an ingredient is added to the next array position
        4 If there are multiple ingredients in the stack then the item is added to the stack and the ingredient is detected to have stopped so that the ingredient stops falling and it cannot be added to the stack again
        */
        for ingredient in entitiesInView {
            // isolation of the movement in a Bool allows all of the falling UIImageViews to run off of one timer
            if ingredient.inStack == false {
                ingredient.image.center.y = ingredient.image.center.y + ingredient.gravity.y
            }
            if ingredientStack[localStackIndex].image.frame.intersects(ingredient.image.frame) {
                if stackIndex == 0{
                    stackIndex += 1
                    addIngredient(ingredient: ingredient)
                } else if stackIndex - 1 != 0 && ingredient.inStack == false {
                    addIngredient(ingredient: ingredient)
                }
                ingredient.inStack = true
            }
        }
    }
    func addIngredient(ingredient: Ingredient!){
        print(stackIndex)
        // adds the ingredient to the ingredientStack based on array position - concurrent with the visual experience of the stack
        ingredientStack.append(Ingredient(name: String(), image: UIImageView(), inStack: false, gravity: CGPoint(x: 0.0, y: 0.0)))
        ingredientStack[stackIndex] = ingredient
        stackIndex += 1
    }
    func spawnIngredients(ingredientType: String, ingredientGravity: CGPoint, location: CGPoint){
        let newIngredient = Ingredient(name: String(), image: UIImageView(), inStack: false, gravity: CGPoint(x: 0.0, y: 0.0)) // creates empty variable
        /*
         Defines attributes of the image of each new ingredient
         1. Image based on a randomization of the ingredients
         2. Location based on a generated value
         3. Size is constant
         4. Applys UIImageView to Ingredient() variable
         5. Uses the same name of ingredientType for future tracking and comparison (check order accuracy)
         6. Gravity based on a generated value
         */
        
        let newIngredientImage: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: ingredientType)
            imageView.center = location
            imageView.frame = CGRect(origin: location, size: ingredientSize)
            return imageView
        }()
        newIngredient.image = newIngredientImage
        newIngredient.name = ingredientType
        newIngredient.gravity = ingredientGravity
        
        entitiesInView.append(newIngredient)
        self.view.addSubview(newIngredient.image)
    }
    
}
    /*
    Old ingredient stack management for reference
 
    itemGravity.y = 5 // speed of fall of ingredient UIImageView
    topIngredientGravity.y = 2.5 // speed of fall of topIngredient UIImageView
 
    if ingredientStack[localStackIndex].image.frame.intersects(ingredient.frame){
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

    if ingredientStack[localStackIndex].image.frame.intersects(topIngredient.frame){
        if stackIndex == 0 {
            stackIndex += 1
            addIngredient(ingredient: topIngredient)
        } else if stackIndex - 1 != 0 && stopTopIngredient == false {
            addIngredient(ingredient: topIngredient)
        }
        
        stopTopIngredient = true
    }
    */
