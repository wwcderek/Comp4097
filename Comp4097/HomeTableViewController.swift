//
//  HomeTableViewController.swift
//  Comp4097
//
//  Created by Wong Wai Chun on 17/10/4.
//  Copyright © 2017年 Wong Wai Chun. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

class HomeTableViewController: UITableViewController {
    var firedJson:JSON?;
    var realmResults:Results<Property>?
    var estate:String?;
    var name:String?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        realmResults = realm.objects(Property.self)
        self.tableView.reloadData()
        let url = "http://localhost:1337/"
        
        
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            
            print("Result: \(response.result)") // response serialization result
            
            switch response.result {
                
            case .success(let value):
                
                // print("JSON: \(value)") // serialized json response
                
                let json = JSON(value)
                realm.beginWrite()
                
                for (index,subJson):(String, JSON) in json {
                    let entry: Property = Property(JSONString: subJson.rawString()!)!
                    realm.add(entry, update: true)
                    print(index);
                }
                
                do {
                    try realm.commitWrite()
                } catch {
                }
                
                self.realmResults = realm.objects(Property.self)

                //print("A record: \(self.firedJson?[0]["name"].stringValue ?? "No Data" )")
                //print("A record: \(self.firedJson?[0]["imageurl"].stringValue ?? "No Data" )")
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let results = realmResults {
            return results.count
        } else {
            return 0
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath)
        
        // Configure the cell...
        
        if let cellImage = cell.viewWithTag(100) as? UIImageView {
            
            let firedUrl = realmResults?[indexPath.row].image
            
            if let url = firedUrl {
                
                Alamofire.request(url).responseData {
                    response in
                    
                    if let data = response.result.value {
                        cellImage.image = UIImage(data: data, scale:1)
                    }
                }
            }
            
        }
        if let cellLabel = cell.viewWithTag(101) as? UILabel {
            cellLabel.text = realmResults?[indexPath.row].estate
            estate = realmResults?[indexPath.row].estate
        }
        
        if let cellLabel2 = cell.viewWithTag(102) as? UILabel {
            cellLabel2.text = realmResults?[indexPath.row].name        }
        
        return cell
    }

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
        
        if segue.identifier == "showDetail" {
            
            if let viewController = segue.destination as? DetailTableViewController {
                
               // var selectedIndex = tableView.indexPathForSelectedRow!
                
                viewController.estate = estate!
                
            }
        }
    }

}
