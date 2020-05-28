//
//  GameHistoryDetailController.swift
//  stackFoodGame
//
//  Created by Michael Hayes on 5/21/20.
//  Copyright © 2020 Michael Hayes. All rights reserved.
//

import UIKit

class GameHistoryDetailController: UIViewController {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var coinsLabel: UILabel!
    @IBOutlet weak var totalCoinsLabel: UILabel!
    
    
    var detailContent = (avatar: String(), date: Date(), location: String(), coins: Int16(), totalCoins: Int16())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        /* For actual implementation with full Core Data
        locationLabel.text = detailContent.location
        coinsLabel.text = String(detailContent.coins)
        */
        let displayFormatter = DateFormatter()
        displayFormatter.dateStyle = .medium // sets format to MM dd, YYYY
        displayFormatter.timeStyle = .medium // sets time format to h:mm:s a
        let universalDate = detailContent.date
        let localDate = displayFormatter.string(from: universalDate)
        
        let avatarImageName = detailContent.avatar
        avatarImage.image = UIImage(named: avatarImageName)
        dateLabel.text = String(localDate)
        locationLabel.text = detailContent.location
        coinsLabel.text = String(detailContent.coins)
        totalCoinsLabel.text = String(detailContent.totalCoins)
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
