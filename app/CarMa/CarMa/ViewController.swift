//
//  ViewController.swift
//  CarMa
//
//  Created by Dianprakasa, Arif on 1/29/20.
//  Copyright © 2020 Dianprakasa, Arif. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, BaseconnectionProtocol
{
    

    //Properties
    var feedItems: NSArray = NSArray()
    var selectedLocation : UserModel = UserModel()
    
    var accountfname = ""
    var accountlname = ""
    
    @IBOutlet weak var account_name: UILabel!
    
    var emailfromlogin = ""
    
    // output
    override func viewDidLoad()
    {
        super.viewDidLoad()
                
        //set delegates and initialize homeModel
        let homeModel = Baseconnection()
        homeModel.delegate = self
        homeModel.downloadItems()
    }
    
    
    func itemsDownloaded(items: NSArray)
    {
        feedItems = items
    
         //use while loop to print the data in order
        var index = 0
        while index < feedItems.count
        {
            let item: UserModel = feedItems[index] as! UserModel
            
            if(item.email! == emailfromlogin)
            {
           
            }
            // test print in console below
            print(item.first_name! + " " + item.last_name! + " " + item.email!)
            
           // display the result in the storyboard
           // output.text! += item.first_name! + item.last_name! + item.email!
            
            // increment index
           index = index + 1
        }
    
                  
func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "findvehicle"
        {
            var vc = segue.destination as! UINavigationController
            var firstvc = vc.viewControllers[0] as! mapViewController
            
            print("segue execeuted")
        }
    }
    
    

}
    @IBAction func edit(_ sender: Any) {
        let alertController = UIAlertController(title: "Edit reservation", message: "Are you sure you want to edit your reservation", preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {(action) -> Void in
           //The (withIdentifier: "VC2") is the Storyboard Segue identifier.
           self.performSegue(withIdentifier: "newreservation", sender: self)
        })

           alertController.addAction(ok)
           self.present(alertController, animated: true, completion: nil)
    }
    
}
