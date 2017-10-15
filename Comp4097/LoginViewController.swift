//
//  LoginViewController.swift
//  Comp4097
//
//  Created by Wong Wai Chun on 17/10/15.
//  Copyright © 2017年 Wong Wai Chun. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class LoginViewController: UIViewController {
   var url = "";
   var name = ""
    var firedJson:JSON?;
    @IBOutlet weak var userid: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        let parameters : Parameters = ["userid": userid.text!, "password": password.text!]
        
        url = "http://localhost:1337/user/login?name=\(userid.text!)&password=\(password.text!)"
        
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
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showClick(_ sender: Any) {
        url = "http://localhost:1337/property/interestedList"
            
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
