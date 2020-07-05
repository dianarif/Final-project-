//
//  Usermodel.swift
//  CarMa
//
//  Created by Dianprakasa, Arif on 1/29/20.
//  Copyright © 2020 Dianprakasa, Arif. All rights reserved.
//

import Foundation

class UserModel: NSObject {
    
    //properties
    
    var first_name: String?
    var last_name: String?
    var email: String?
    var phone: String?
    var type: String?
    var dob: String?
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name, @address, @latitude, and @longitude parameters
    
    init(first_name: String, last_name: String, email: String, phone: String, type: String, dob: String) {
        
        self.first_name = first_name
        self.last_name = last_name
        self.email = email
        self.phone = phone
        self.type = type
        self.dob = dob
        
    }
    
    
    //prints object's current state
    
    override var description: String {
        return "First Name: \(first_name!), Last Name: \(last_name!), Email: \(email!), Phone: \(phone!), Type: \(type!), Date of birth: \(dob!)"
        
    }
    
    
}
