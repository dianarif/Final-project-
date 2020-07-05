//
//  Baseconnection.swift
//  CarMa
//
//  Created by Dianprakasa, Arif on 1/29/20.
//  Copyright © 2020 Dianprakasa, Arif. All rights reserved.
//

import Foundation

protocol BaseconnectionProtocol: class {
    func itemsDownloaded(items: NSArray)
}
 
 
class Baseconnection: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: BaseconnectionProtocol!
    
    let urlPath = "http://cgi.soic.indiana.edu/~team05/user.php"
    //this will be changed to the path where your php is stored
    
    
    //
    func downloadItems() {
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                print("Data downloaded")
                self.parseJSON(data!)
            }
        }
        
        task.resume()
    }
    
    //
    func parseJSON(_ data:Data) {
        
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
        } catch let error as NSError {
            print(error)
            
        }
        
        var jsonElement = NSDictionary()
        let locations = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let User = UserModel()
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let first_name = jsonElement["first_name"] as? String,
                let last_name = jsonElement["last_name"] as? String,
                let email = jsonElement["email"] as? String,
                let phone = jsonElement["phone"] as? String,
                let type = jsonElement["type"] as? String,
                let dob = jsonElement["dob"] as? String
            {
                
                User.first_name = first_name
                User.last_name = last_name
                User.email = email
                User.phone = phone
                User.type = type
                User.dob = dob
            }
            
            // for testing to print names from database
            //print(User.first_name!)
            //print(User.last_name!)
            locations.add(User)
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.itemsDownloaded(items: locations)
            
        })
    }
}
