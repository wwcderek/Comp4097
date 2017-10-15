//
//  InterestedTableViewController.swift
//  Comp4097
//
//  Created by Wong Wai Chun on 17/10/15.
//  Copyright © 2017年 Wong Wai Chun. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

struct interestedInfo {
    var name:String
}
class InterestedTableViewController: UITableViewController {
     var url = "";
     var firedJson:JSON?;
    var arr = [String]()
    var arr2 = ["Festival City", "City One"]
     var nameArray = [interestedInfo]()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        for index in 1...4 {
        url = "http://localhost:1337/property/showInterestedUser?id=\(index)"
            Alamofire.request(url, method: .get)
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        self.firedJson = JSON(value)
                        let name = String(describing: (self.firedJson?["interestedFor"][0]["name"])!)
                        if(name.caseInsensitiveCompare("MartinChoy") == ComparisonResult.orderedSame) {
                            //print(self.firedJson?["name"])
                           // self.nameArray.append(interestedInfo(name: "\(self.firedJson?["name"])"))
                            self.arr.append(String(describing: (self.firedJson?["name"])!))
                        }
                    case .failure(let error):
                        print(error)
                    }
                   
                   // let num2 = self.nameArray.count
                   // print(self.num);
            }}
               print("Interested property are \(self.arr)")
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
        return self.arr2.count
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "testCell", for: indexPath)

        // Configure the cell...
        
        cell.textLabel?.text = self.arr2[indexPath.row]
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

}
