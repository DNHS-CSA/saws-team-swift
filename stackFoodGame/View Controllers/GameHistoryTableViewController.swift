//
//  GameHistoryTableViewController.swift
//  stackFoodGame
//
//  Created by Michael Hayes on 5/21/20.
//  Copyright © 2020 Michael Hayes. All rights reserved.
//

import UIKit
import CoreData

class GameHistoryTableViewController: UITableViewController {

    var managedObjectContext: NSManagedObjectContext!
    var gameLogData = [GameHistory()]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        loadData()
        
        let currentTime = Date() // creates date - Date() default is current time
        
        let displayFormatter = DateFormatter() // can either format how a date is saved or parsed
        displayFormatter.dateStyle = .medium // displays date in readable form to user - works in different locales
        displayFormatter.timeStyle = .medium // displays time in readable form to user
        
        let displayString = displayFormatter.string(from: currentTime)
        print(displayString)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    // MARK: - CoreData management
    func loadData(){
           do{
            gameLogData = try managedObjectContext.fetch(GameHistory.fetchRequest())
           } catch {
               print("Load failed due to \(error.localizedDescription)")
           }
        self.tableView.reloadData()
    }

    // MARK: - Randomizer sample data
    func randomizer(typeOfSampleData: String) -> String {
        /*
         Switch statement that either creates sample random data for location or coin value
         */
        
        var sampleData = String()
        
        switch typeOfSampleData {
            case "Location":
                sampleData = locations.randomElement()!
                break
            case "Coin":
                sampleData = String(Int.random(in: 1...200))
                break
            default:
                print("Wrong parameter")
                break
        }
        return sampleData
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //corresponds to height of cells in Table View
        return 150
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return the number of rows in data source
        return gameLogData.count
    }
    
    //Data load cells from Core Data (data)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //cell refererence in Table View
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameHistoryCell", for: indexPath) as! GameHistoryTableViewCell
        
        //row or object in data source
        let logEntry = gameLogData[indexPath.row]
        
        //cell.location.text = "Location" + String(logEntry.location?.name ?? "No location - error") // sets the location to real location and catches any Core Data relationship errors
        cell.location.text = "Location: " + String("\(randomizer(typeOfSampleData: "Location"))")
        cell.coins.text = "Coins Earned: " + String(Int.random(in: 1...200)) // sets coin value to filler value
        // next line will work once we have coin data for each player
        //cell.coins.text = String(logEntry.coins)
    
        /*
         Extra lines of code for date display
         1. First thing to understand about dates: they are stored in UTC time in universal format, whole point of a displayFormatter is to make date readable in our style (en_US)
         2. Sets the display formatter to normal style in US
         3. Sets universally formatted date stored in Core Data to a variable
         4. Assigns display to the date using the formatted system.
         */
        let displayFormatter = DateFormatter()
        displayFormatter.dateStyle = .medium // sets format to MM dd, YYYY
        let universalDate = logEntry.date
        cell.date.text = displayFormatter.string(from: universalDate!)
        return cell
    }


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
