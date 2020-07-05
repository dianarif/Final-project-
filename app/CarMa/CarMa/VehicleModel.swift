//
//  vehicleModel.swift
//  CarMa
//
//  Created by Dianprakasa, Arif on 2/22/20.
//  Copyright © 2020 Dianprakasa, Arif. All rights reserved.
//

import Foundation

class vehicleModel: NSObject {
    
    //properties
    
    var license_plate: String?
    var type: String?
    var model: String?
    var availability: String?
    var battery_level: String?
    var rate: String?
    var photo: String?
    var features: String?
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name, @address, @latitude, and @longitude parameters
    
    init(license_plate: String, type: String, model: String, availability: String, battery_level: String, rate: String, photo: String, features: String) {
        
        self.license_plate = license_plate
        self.type = type
        self.model = model
        self.availability = availability
        self.battery_level = battery_level
        self.rate = rate
        self.photo = photo
        self.features = features
    }
    
    
    //prints object's current state
    
    override var description: String
    {
        return "license_plate: \(license_plate!), type: \(type!), model: \(model!), availability: \(availability!), battery_level: \(battery_level!), rate: \(rate!), photo: \(photo!), features: \(features!)"
    }


}
