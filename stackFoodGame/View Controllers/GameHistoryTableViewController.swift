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

    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    var gameLogData = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        // flips Y axis so that the table view populates from the top
        //tableView.transform = CGAffineTransform(scaleX: 1, y: -1)

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
        let player = appDelegate?.getRecordsFor(entity: "Player").first as! Player
        gameLogData = player.gameHistory.allObjects as! [NSManagedObject]
        
        print(gameLogData.count)
        if gameLogData.count == 0 {
            return
        }
        sortDataByDate()
        
        for l in gameLogData{
            print(l.value(forKey: "avatarName") as Any)
            print(l.value(forKey: "coins") as Any)
            print(l.value(forKey: "date") as Any)
        }
        self.tableView.reloadData()
    }

    func sortDataByDate(){
        var sdata : [NSManagedObject] = [gameLogData[0]] //adding 1 to start

        gameLogData = Array(gameLogData.dropFirst(1))
        
        for g in gameLogData{
            
            for i in (0..<sdata.count){
                
                let gdate = g.value(forKey: "date") as! Date
                let sdate = sdata[i].value(forKey: "date") as! Date
                
                if gdate < sdate{
                    sdata.insert(g, at: i)
                    break
                }
                
                if i == sdata.count-1{ //will insert at the end if finished
                    sdata.append(g)
                }
            }
            
        }
        
        gameLogData = sdata
        
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
        //flips cell so that the tableview is populated from the top
        //cell.contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
        
        //row or object in data source
        let logEntry = gameLogData[indexPath.row] as! GameHistory
        
        
        // lines below will work on Core Data is implemented

        //let avatarImageName = logEntry.player?.avatar?.iconName
        
        cell.avatar.image = UIImage(named: logEntry.avatarName)
        cell.coins.text = String(logEntry.coins)
        cell.location.text = String(logEntry.location?.name ?? "No location saved") // sets the location to real location and catches any Core Data relationship errors
        
        /*
         Extra lines of code for date display
         1. First thing to understand about dates: they are stored in UTC time in universal format, whole point of a displayFormatter is to make date readable in our style (en_US)
         2. Sets the display formatter to normal style in US
         3. Sets universally formatted date stored in Core Data to a variable
         4. Assigns display to the date using the formatted system.
         */
        let displayFormatter = DateFormatter()
        displayFormatter.dateStyle = .medium // sets format to MM dd, YYYY
        let universalDate = logEntry.value(forKey: "date") as! Date
        cell.date.text = displayFormatter.string(from: universalDate)
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


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)

        switch segue.identifier ?? "" {
        case "viewHistoryDetail":
            //Get Cell object
            guard let gameHistoryCell = sender as? GameHistoryTableViewCell else {
                fatalError("Unable to retrieve cell")
            }

            //Get current index
            guard let indexPath = tableView.indexPath(for: gameHistoryCell) else {
                fatalError("Could not find current index")
            }
            let currentGameHistoryCell = gameLogData[indexPath.row] as! GameHistory
            //Provide destination segue reference
            guard let gameHistoryDetail = segue.destination as? GameHistoryDetailController else {
                fatalError("Could not find GameHistoryDetailController")
            }
            gameHistoryDetail.detailContent.avatar = currentGameHistoryCell.player?.avatar?.name ?? ""
            gameHistoryDetail.detailContent.date = currentGameHistoryCell.date!
            gameHistoryDetail.detailContent.location = currentGameHistoryCell.location?.name ?? "No location saved"
            gameHistoryDetail.detailContent.coins = currentGameHistoryCell.coins
            gameHistoryDetail.detailContent.totalCoins = (currentGameHistoryCell.player?.coins)!
            
        default:
            print("Did not locate segue identifier")
        }
    }
}
