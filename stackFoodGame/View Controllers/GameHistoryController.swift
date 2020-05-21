//
//  GameHistoryController.swift
//  stackFoodGame
//
//  Created by Michael Hayes on 5/20/20.
//  Copyright © 2020 Michael Hayes. All rights reserved.
//

import UIKit

class GameHistoryController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentTime = Date() // creates date - Date() default is current time
        
        let displayFormatter = DateFormatter() // can either format how a date is saved or parsed
        displayFormatter.dateStyle = .medium // displays date in readable form to user - works in different locales
        displayFormatter.timeStyle = .medium // displays time in readable form to user
        
        let displayString = displayFormatter.string(from: currentTime)
        print(displayString)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
