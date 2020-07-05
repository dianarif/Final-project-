//
//  updatephoneViewController.swift
//  CarMa
//
//  Created by Emily Oneal on 2/25/20.
//  Copyright © 2020 Dianprakasa, Arif. All rights reserved.
//

import UIKit

class updatephoneViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
         

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var old_phone: UITextField!
    @IBOutlet weak var new_phone: UITextField!
    
    
    @IBAction func editphone(_ sender: Any)
    {
            
            guard let old_phone = old_phone.text,
                let new_phone = new_phone.text
            else {
               return
            }
            
            // Validation check
           
            let url = URL(string: "http://cgi.soic.indiana.edu/~team05/updatephone.php") // locahost MAMP - change to point to your database server
                    
            var request = URLRequest(url: url!)
                    request.httpMethod = "POST"
                    
                    var dataString = "secretWord=44fdcv8jf3" // starting POST string with a secretWord
            
            // the POST string has entries separated by &

                    dataString = dataString + "&old_phone=\(old_phone)"
                    dataString = dataString + "&new_phone=\(new_phone)"
                
                    
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
                                            let alert = UIAlertController(title: "phone number was changed", message: "Your phone number was successfully changed", preferredStyle: .alert)
                                           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
                                                action in

                                                    self.dismiss(animated: true, completion: nil)


                                            }))

                                                self.present(alert, animated: true, completion: nil)
                                        }
                                    }
                                    else
                                    {
                                        // display an alert if an error and database insert didn't worked (return != 1) inside the DispatchQueue.main.async
                                        DispatchQueue.main.async
                                        {

                                        let alert = UIAlertController(title: "phone number was changed", message: "Your phone number was successfully changed.", preferredStyle: .alert)
                                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
                                            action in

                                                self.dismiss(animated: true, completion: nil)


                                        }))

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

