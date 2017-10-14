//
//  RegionTableViewController.swift
//  Comp4097
//
//  Created by Wong Wai Chun on 17/10/13.
//  Copyright © 2017年 Wong Wai Chun. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire
import SwiftyJSON



class RegionTableViewController: UITableViewController {
    var id = "";
    var url = "";
    var firedJson:JSON?;
    var results:Results<Estates>?
    var realmResults:Results<Property>?
    var data = [[], [], [], []]
    var headerTitles = ["Hong Kong Island", "Kowloon", "New Territories East", "New Territories South-west"]
    override func viewDidLoad() {
        super.viewDidLoad()
        let config = Realm.Configuration(
            // Get the URL to the bundled file
            fileURL: Bundle.main.url(forResource: "privateEstates", withExtension: "realm"),
            // Open the file in read-only mode as application bundles are not writeable
            readOnly: true)
        let realm = try! Realm(configuration: config)
        results = realm.objects(Estates.self)

        for result in results! {
           // print(result.Name)
            if(result.District.caseInsensitiveCompare(self.headerTitles[0]) == ComparisonResult.orderedSame) {
                self.data[0].append(result.Name)
            } else if(result.District.caseInsensitiveCompare(self.headerTitles[1]) == ComparisonResult.orderedSame) {
                self.data[1].append(result.Name)
            } else if(result.District.caseInsensitiveCompare(self.headerTitles[2]) == ComparisonResult.orderedSame) {
                self.data[2].append(result.Name)
            } else if(result.District.caseInsensitiveCompare(self.headerTitles[3]) == ComparisonResult.orderedSame) {
                self.data[3].append(result.Name)
            }
           
        }
        
   

        
     
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < headerTitles.count {
            return headerTitles[section]
        }
    
        return nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return headerTitles.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data[section].count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "regionCell", for: indexPath)
        
        // Configure the cell...
        
        cell.textLabel?.text = String(describing: data[indexPath.section][indexPath.row])
        
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showSelection2" {
            
            if let viewController = segue.destination as? Selection2TableViewController {
                var selectedIndex = tableView.indexPathForSelectedRow!
                let currentCell = tableView.cellForRow(at: selectedIndex)! as UITableViewCell
                viewController.name = (currentCell.textLabel?.text)!
             
              
            }
        }
    }

}
