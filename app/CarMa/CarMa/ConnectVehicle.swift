//
//  ConnectVehicle.swift
//  CarMa
//
//  Created by Dianprakasa, Arif on 2/22/20.
//  Copyright © 2020 Dianprakasa, Arif. All rights reserved.
//

import Foundation

protocol ConnectVehicleProtocol: class {
    func itemsDownload(items: NSArray)
}


class ConnectVehicle: NSObject, URLSessionDataDelegate{
    
    //properties
    
    weak var delegate: ConnectVehicleProtocol!
    
    let urlPath = "http://cgi.soic.indiana.edu/~team05/vehicle.php"
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
        let Vehicles = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let Vehicle = vehicleModel()
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let license_plate = jsonElement["license_plate"] as? String,
                let type = jsonElement["type"] as? String,
                let model = jsonElement["model"] as? String,
                let availability = jsonElement["availability"] as? String,
                let battery_level = jsonElement["battery_level"] as? String,
                let rate = jsonElement["rate"] as? String,
                let photo = jsonElement["photo"] as? String,
                let features = jsonElement["features"] as? String
                {
                    
                    Vehicle.license_plate = license_plate
                    Vehicle.type = type
                    Vehicle.model = model
                    Vehicle.availability = availability
                    Vehicle.battery_level = battery_level
                    Vehicle.rate = rate
                    Vehicle.photo = photo
                    Vehicle.features = features
                }
            
            // for testing to print names from database
            //print(User.first_name!)
            //print(User.last_name!)
            Vehicles.add(Vehicle)
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.itemsDownload(items: Vehicles)
            
        })
    }


}
