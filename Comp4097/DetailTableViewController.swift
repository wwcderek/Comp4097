//
//  DetailTableViewController.swift
//  Comp4097
//
//  Created by Wong Wai Chun on 17/10/8.
//  Copyright © 2017年 Wong Wai Chun. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

class DetailTableViewController: UITableViewController {
    var number = 0
    var id = 0;
    var realmResults:Results<Property>?
    var property:Property?
    var firedJson:JSON?;
    var url = "";
    @IBAction func bt_click(_ sender: Any) {
       print("see?")
        url = "https://mighty-caverns-73776.herokuapp.com/property/interestedProperty?id=\(self.id)"
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    self.firedJson = JSON(value)
                    let alertController = UIAlertController(title: "Title", message: String(describing: self.firedJson!), preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                case .failure(let error):
                    print(error)
                }
        }
    
    
    
    
    
//        let alertController = UIAlertController(title: "Title", message: "Are you sure? Declare Interest on this property", preferredStyle: .alert)
//        alertController.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
//        alertController.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
//        let url = "http://localhost:1337/property/detail?id=\(self.id)"
//        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.title = realmResults?[number].estate
//        realmResults2 = realm.objects(Property.self)
        print("id is \(self.id)");
        let url = "https://mighty-caverns-73776.herokuapp.com/property/detail?id=\(self.id)"
        //self.tableView.reloadData()
        
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            
            // print("Result: \(response.result)") // response serialization result
            
            switch response.result {
                
            case .success(let value):
                
         
                let json = JSON(value)
                
                self.property = Property(JSONString: json.rawString()!)!
                let num = self.property?.estate
                print(num!)
                
                self.title = self.property?.estate
        

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
        return 1
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath)
        
        // Configure the cell...
        
        if let cellImage = cell.viewWithTag(100) as? UIImageView {
            
            let firedUrl = self.property?.image
            
            if let url = firedUrl {
                
                Alamofire.request(url).responseData {
                    response in
                    
                    if let data = response.result.value {
                        cellImage.image = UIImage(data: data, scale:1)
                    }
                }
            }
            
        }
        if let cellLabel2 = cell.viewWithTag(102) as? UILabel {
            cellLabel2.text = "Rent: " + String(describing: self.property?.rent)
        }
        
        if let cellLabel = cell.viewWithTag(101) as? UILabel {
            cellLabel.text = "Garea: " + String(describing: self.property?.garea)
        }
////
        if let cellLabel2 = cell.viewWithTag(102) as? UILabel {
            cellLabel2.text = "Rent: " + String(describing: self.property?.rent)     }
//
        if let cellLabel3 = cell.viewWithTag(103) as? UILabel {
            cellLabel3.text = "Badrooms: " + String(describing: self.property?.bedrooms)
        }
//
        if let cellLabel4 = cell.viewWithTag(104) as? UILabel {
            cellLabel4.text = "Excepted Tenants: " + String(describing: self.property?.tenants)
        }
//
        if let cellLabel5 = cell.viewWithTag(105) as? UILabel {
            cellLabel5.text =  self.property?.name
       }
//
        if let cellLabel6 = cell.viewWithTag(106) as? UILabel {
            cellLabel6.text =  "Create Date: " + String(describing: self.property?.createdAt)
      }
        
        if let cellLabel7 = cell.viewWithTag(107) as? UILabel {
            cellLabel7.text =  "Updated Date: " + String(describing: self.property?.updatedAt)    }
        
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
        
        if segue.identifier == "showMap" {
            
            if let viewController = segue.destination as? MapViewController {
               
                
                viewController.realmResults = realmResults
                
                viewController.number = number 
                
                
            }
        }
    }

}
