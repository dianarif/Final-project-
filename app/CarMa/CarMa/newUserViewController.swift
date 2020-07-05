//
//  newUserViewController.swift
//  CarMa
//
//  Created by Dianprakasa, Arif on 2/7/20.
//  Copyright © 2020 Dianprakasa, Arif. All rights reserved.
//

import UIKit
class newUserViewController: UIViewController {
    
    //source link https://www.boomer.org/ios/sdb/
    
    var validation = Validation()
    
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
    }
    
    //storyboard
    @IBOutlet weak var first_name: UITextField!
    @IBOutlet weak var last_name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var dob: UIDatePicker!
    @IBOutlet weak var phone: UITextField!
   
  
    // when register button is pressed
    @IBAction func addNewuser(_ sender: Any) {
        
        guard let first_name = first_name.text,
              let last_name = last_name.text,
              let email = email.text,
              let dob = dob,
              let phone = phone.text
        else {
           return
        }
        
        // Validation check
        let isValidatefirst_name = self.validation.validatefirst_name(first_name: first_name)
        if (isValidatefirst_name == false) {
           print("Incorrect first_name")
           return
        }
        let isValidatelast_name = self.validation.validatelast_name(last_name: last_name)
        if (isValidatelast_name == false) {
           print("Incorrect last_name")
           return
        }
        let isValidateemail = self.validation.validateemail(email: email)
        if (isValidateemail == false) {
           print("Incorrect email")
           return
        }
        let isValidatephone = self.validation.validatephone(phone: phone)
        if (isValidatephone == false) {
           print("Incorrect phone")
           return
        }
        if (isValidatefirst_name == isValidatefirst_name || isValidatelast_name == isValidatelast_name || isValidateemail == isValidateemail || isValidatephone == isValidatephone) {
           print("All fields are correct")
        
          
            
            
        let url = URL(string: "http://cgi.soic.indiana.edu/~team05/main.php") // locahost MAMP - change to point to your database server
                
        var request = URLRequest(url: url!)
                request.httpMethod = "POST"
                
                var dataString = "secretWord=44fdcv8jf3" // starting POST string with a secretWord
        
        // the POST string has entries separated by &
                dataString = dataString + "&first_name=\(first_name)" // add items as name and value
                dataString = dataString + "&last_name=\(last_name)"
                dataString = dataString + "&email=\(email)"
                dataString = dataString + "&phone=\(phone)"
                dataString = dataString + "&dob=\(dob.date)"
                
        // convert the post string to utf8 format
                
                let dataD = dataString.data(using: .utf8) // convert to utf8 string
                
                do
                {
                
        // the upload task, uploadJob, is defined here

                    let uploadJob = URLSession.shared.uploadTask(with: request, from: dataD)
                    {
                        data, response, error in
                        
                        if error != nil {
                            
        // display an alert if there is an error inside the DispatchQueue.main.async

                            DispatchQueue.main.async
                            {
                                    let alert = UIAlertController(title: "Upload Didn't Work?", message: "Looks like the connection to the server didn't work.  Do you have Internet access?", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                            }
                        }
                        else
                        {
                            if let unwrappedData = data {
                                
                                let returnedData = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue) // Response from web server hosting the database
                                
                                if returnedData == "1" // insert into database worked
                                {

        // display an alert if no error and database insert worked (return = 1) inside the DispatchQueue.main.async

                                    DispatchQueue.main.async
                                    {
                                        let alert = UIAlertController(title: "Upload OK?", message: "Looks like the upload and insert into the database worked.", preferredStyle: .alert)
                                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                                        self.present(alert, animated: true, completion: nil)
                                    }
                                }
                                else
                                {
        // display an alert if an error and database insert didn't worked (return != 1) inside the DispatchQueue.main.async

                                    DispatchQueue.main.async
                                    {

                                    let alert = UIAlertController(title: "Upload Didn't Work", message: "Looks like the insert into the database did not worked.", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                                    }
                                }
                            }
                        }
                    }
                    uploadJob.resume()
                }
            }
    }
    
    
        // Do any additional setup after loading the view.

    


}
