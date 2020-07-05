//
//  VehicleInfoViewController.swift
//  AppAuth
//
//  Created by Gabriela Putri Prabowo on 22/02/20.
//

import UIKit

class VehicleInfoViewController: UIViewController, UITableViewDelegate{
        

        //Properties
        var feedItems: NSArray = NSArray()
        //var selectedLocation : VehicleModel = VehicleModel()
        
        
        // output

        
        
        override func viewDidLoad() {
            super.viewDidLoad()
                    
                    //set delegates and initialize homeModel
                    //let homeModel = BaseConnectionVehicle()
                    //homeModel.delegate = self
                    //homeModel.downloadItems()
            
                    
                    
            }
        
        func itemsDownload(items: NSArray) {
            feedItems = items
            
            // use while loop to print the data in order
            var index = 0
            while index < feedItems.count
            {
                //let item: VehicleModel = feedItems[index] as! VehicleModel
                
                // test print in console below
                //print(item.first_name! + " " + item.last_name! + " " + item.email!)
                
                //display the result in the storyboard
                //output.text! += item.first_name! + item.last_name! + item.email!
                
                // increment index
                index = index + 1
            }
        }
                
                            
                
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


