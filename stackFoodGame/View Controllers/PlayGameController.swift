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
    var zPositionIngredient: CGFloat = 0.1
    var stackIndex: Int = 0
    var ingredientSize = CGSize(width: 80.0, height: 46.0)
    var ingredientAlignment = CGPoint(x: 0.0, y: 0.0)
    
    var entitiesInView: [Ingredient] = []
    @IBOutlet weak var middleDetector: UIImageView!
    
    var timer:Timer? = Timer()
    var spawnTimer:Timer? = Timer()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        ingredientStack.append(Ingredient(name: String(), image: UIImageView(), inStack: false, gravity: CGPoint(x: 0.0, y: 0.0), location: CGPoint(x: 0.0, y: 0.0), isPastMiddle: false))
        ingredientStack[stackIndex].image = ingredientCatcher // array of UIImageViews that fills up based on what is in the stack- first element is the base (ingredientCatcher)
        ingredientStack[stackIndex].name = "ingredientCatcher"
        
        timer = Timer.scheduledTimer(timeInterval: 0.025, target: self, selector: #selector(moveItem), userInfo: nil, repeats: true)
        spawnTimer = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(randomizedSpawner), userInfo: nil, repeats: true)
        middleDetector.isUserInteractionEnabled = false
        /*spawnIngredients(ingredientType: "burger", ingredientGravity: CGPoint(x: 0.0, y: 8.0), location: CGPoint(x: 80.0, y: 60.0))
        spawnIngredients(ingredientType: "tomato", ingredientGravity: CGPoint(x: 0.0, y: 2.5), location: CGPoint(x: 230.0, y: 90.0))
        spawnIngredients(ingredientType: "tomato", ingredientGravity: CGPoint(x: 0.0, y: 2.0), location: CGPoint(x: 320.0, y: 90.0))
        //entitiesInView.append(Ingredient(name: String(), image: ingredient, inStack: false, gravity: CGPoint(x: 0.0, y: 5.0)))
        //entitiesInView.append(Ingredient(name: String(), image: topIngredient, inStack: false, gravity: CGPoint(x: 0.0, y: 2.5)))*/
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
    @objc func randomizedSpawner(){
        /*
         Built in Swift randomization functions
         */
        var randomLocation = locationSpawns.randomElement()
        let randomYValue = Double.random(in: 1..<8)
        var trafficPrevention = 0
        var randomGravity = CGPoint(x: 0.0, y: randomYValue)
        let randomIngredient = ingredientTypes.randomElement()
        /*
         Method explanation: Purpose is to limit the number of ingredients that overlap each other, but not reduce the overlap all together
         1. Scans all of the entities in the view to see if the new location of an element to be spawned is in the same "column" (see playGameDictionaries) as an existing falling ingredient
         2. Swift repeat (do while) randomizes another gravity value until it is less than the gravity of the ingredient already falling in the current column
         3. If a smaller gravity value cannot be found after 30 attempts, it spawns the ingredient in a different random location
         */
        for ingredient in entitiesInView {
            if randomLocation!.x == ingredient.location.x && ingredient.isPastMiddle == false {
                repeat { // Swift version of do while
                    let newRandomYValue = Double.random(in: 1..<8) // attemped solution to new random number that uses the half open operator by using the gravity as the limiter (error: ClosedRange<Int> cannot be converted to ClosedRange<_>)
                    randomGravity = CGPoint(x: 0.0, y: newRandomYValue)
                    trafficPrevention += 1
                } while randomGravity.y > ingredient.gravity.y || trafficPrevention == 30
                /*randomYValue = Double(ingredient.gravity.y - 0.9)
                randomGravity = CGPoint(x: 0.0, y: randomYValue)*/
            } else if trafficPrevention == 30 {
                randomLocation = locationSpawns.randomElement()
            }
        }
        
        spawnIngredients(ingredientType: randomIngredient!, ingredientGravity: randomGravity, location: randomLocation!)
    }
    
    @objc func moveItem(){
        var localStackIndex = stackIndex
        // addIngredient func always sets up array for a new element, thus if the stack has something in it, to do the tests below, it must look at the previous element
        if stackIndex != 0 {
            localStackIndex = stackIndex - 1
        }
        /*
        Loop explanation
        1. Cycles through all of the entities in the view
        2. If the stack of food (top item only) intersects with the falling ingredient it will stop the falling ingredient from moving
        3. If there is no other items in stack other than the base (array position zero), then an ingredient is added to the next array position
        4. If there are multiple ingredients in the stack then the item is added to the stack and the ingredient is detected to have stopped so that the ingredient stops falling and it cannot be added to the stack again
         5. Position is shifted down after detection to better represent stacked ingredients in UI
         6. Checks if any ingredients are past the middle of the screen by using a UI Image View placed in storyboard
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
                    animateStack(ingredient: ingredient, currentSpeed: ingredient.gravity)
                } else if stackIndex - 1 != 0 && ingredient.inStack == false {
                    addIngredient(ingredient: ingredient)
                    animateStack(ingredient: ingredient, currentSpeed: ingredient.gravity)
                }
                ingredient.inStack = true
            }
            if ingredient.image.frame.intersects(middleDetector.frame){
                ingredient.isPastMiddle = true
            }
        }
    }
    func addIngredient(ingredient: Ingredient!){
        print(stackIndex)
        // adds the ingredient to the ingredientStack based on array position - concurrent with the visual experience of the stack
        ingredientStack.append(Ingredient(name: String(), image: UIImageView(), inStack: false, gravity: CGPoint(x: 0.0, y: 0.0), location: CGPoint(x: 0.0, y: 0.0), isPastMiddle: false))
        ingredientStack[stackIndex] = ingredient
        ingredient.image.layer.zPosition = zPositionIngredient // makes sure the current ingredient in the stack is really at the top in the UI hierachy
        zPositionIngredient += 0.1
        stackIndex += 1
        
        //ADDED BELOW TO SYNC BURGER WITH GLOBAL TRACKER IN ORDER.SWIFT
        orders.last?.curBurger.append(ingredientStack.last!.name)
        
    }
    func animateStack(ingredient: Ingredient, currentSpeed: CGPoint) {
        var animateTimer = 0
        var alignmentController = CGPoint(x: 0, y: 0)
        let centerOfIngredient = CGPoint(x: 0.0, y: 22.5)
        /*
         Method explanation
         1. Runs a timer that moves the ingredient down after it is detected
         2. Use of timer and small movements results in an animation of the ingredient resting in the stack
         3. Animation movements come from the speed of the ingredient (elminates the ingredient changing speed when it enters the detection area) and is stopped once the ingredient falls approximately halfway through the height of the ingredient in the stack
         */
        Timer.scheduledTimer(withTimeInterval: 0.025, repeats: true) { timer in
            animateTimer += 1
            alignmentController.y += currentSpeed.y
            ingredient.image.center.y = ingredient.image.center.y + currentSpeed.y

            if alignmentController.y >= centerOfIngredient.y {
                timer.invalidate()
            }
        }
    }
    func spawnIngredients(ingredientType: String, ingredientGravity: CGPoint, location: CGPoint){
        let newIngredient = Ingredient(name: String(), image: UIImageView(), inStack: false, gravity: CGPoint(x: 0.0, y: 0.0), location: CGPoint(x: 0.0, y: 0.0), isPastMiddle: false) // creates empty variable
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
        newIngredient.location = location
        
        entitiesInView.append(newIngredient)
        self.view.addSubview(newIngredient.image)
    }
    
    
    
    //REMOVE THE BELOW LATER
    @IBAction func finishedOrderButton(_ sender: Any) {
        timer?.invalidate()
        spawnTimer?.invalidate()
        
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
 
    Possible Order Logic
    class Order {
        
        var image: UIImageView
        var label: UILabel
        var ingredientType: String
        var text: String
        var quantity: Int
        
        init(image: UIImageView, label: UILabel, ingredientType: String, text: String, quantity: Int) {
            self.image = image
            self.label = label
            self.ingredientType = ingredientType
            self.text = text
            self.quantity = quantity
        }
    }
 
    ingredientsInOrder.append(Order(image: ingredient1, label: ingredientNumber1, ingredientType: String(), text: String(), quantity: Int()))
    ingredientsInOrder.append(Order(image: ingredient2, label: ingredientNumber2, ingredientType: String(), text: String(), quantity: Int()))
    ingredientsInOrder.append(Order(image: ingredient3, label: ingredientNumber3, ingredientType: String(), text: String(), quantity: Int()))
    
    for ingredient in ingredientsInOrder {
        
        ingredient.quantity = Int.random(in: 1...3)
        ingredient.ingredientType = orderIngredientType.randomElement()!
    }
    var uniqueIngredients: Bool = false
    repeat{
        if ingredientsInOrder[0].ingredientType != ingredientsInOrder[1].ingredientType && ingredientsInOrder[1].ingredientType != ingredientsInOrder[2].ingredientType && ingredientsInOrder[2].ingredientType != ingredientsInOrder[0].ingredientType {
            uniqueIngredients = true
        }
    } while uniqueIngredients == false
    for ingredient in ingredientsInOrder {
        ingredient.image.image = UIImage(named: ingredient.ingredientType)
        ingredient.label.text = "x\(String(ingredient.quantity))"
        
    }
 */

