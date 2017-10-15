//
//  SelectionTableViewController.swift
//  Comp4097
//
//  Created by Wong Wai Chun on 17/10/9.
//  Copyright © 2017年 Wong Wai Chun. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire
import SwiftyJSON

struct nameInfo {
    
    var name:String
    var id:String
}

class SelectionTableViewController: UITableViewController {
    var number = 0;
    var value = 0;
    var id = "";
    var url = "";
    var firedJson:JSON?;
    var realmResults:Results<Property>?
    var nameArray = [nameInfo]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        realmResults = realm.objects(Property.self)
    
       url = "https://mighty-caverns-73776.herokuapp.com/property/selection?rent=\(number)&category=\(value)"
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            print("Result: \(response.result)") // response serialization result
            switch response.result {
            case .success(let value):
                self.firedJson = JSON(value)
                for (_, object) in self.firedJson! {
                    let name = object["name"].stringValue
                    let id = object["id"].stringValue
                    self.nameArray.append( nameInfo(name: "\(name)", id: "\(id)" ) )
                }
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
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
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "selectionCell", for: indexPath)
        
        // Configure the cell...
        
        //cell.textLabel?.text = self.realmResults?[indexPath.row].name
       cell.textLabel?.text = firedJson?[indexPath.row]["name"].stringValue
       // id = (firedJson?[indexPath.row]["name"].stringValue)!
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
        
        if segue.identifier == "showDetail" {
            
            if let viewController = segue.destination as? DetailTableViewController {
                var selectedIndex = tableView.indexPathForSelectedRow!
                var num = selectedIndex[1]
                viewController.id =  Int(self.nameArray[num].id)!
            }
        }
    }

}
