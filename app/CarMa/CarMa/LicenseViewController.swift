//
//  LicenseViewController.swift
//  CarMa
//
//  Created by Tianze Huang on 2/20/20.
//  Copyright © 2020 Dianprakasa, Arif. All rights reserved.
//

import UIKit

class LicenseViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    //for storyboard changes
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //license variables to be input by user
    @IBOutlet weak var myimageview: UIImageView!
    @IBOutlet weak var license_number: UITextField!
    @IBOutlet weak var exp_date: UIDatePicker!
    
    private var selectedData: Data?
    
    // select picture function
    @IBAction func upload(_ sender: Any)
    {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler:{(action:UIAlertAction) in imagePickerController.sourceType = .camera;
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                self.present(imagePickerController, animated: true, completion: nil)}
            else{
                print("Camera not available")
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler:{(action:UIAlertAction) in imagePickerController.sourceType = .photoLibrary; self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    // select picture function
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            myimageview.image = image
            picker.dismiss(animated: true, completion: nil)
            
            //upload picture code-----------------------------------------------------------------------------------------------------------------------
            
            let url = URL(string: "http://cgi.soic.indiana.edu/~team05/uploadlicense.php") // locahost MAMP - change to point to your database server
                      
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
              

            // THE CODE TO UPLOAD IMAGE--------------------------------------------------------------------------------------------------
            let imageData = myimageview.image!.pngData()

            let boundary = generateBoundaryString()

            //the ones that triggers the error to input license info
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

            if (myimageview.image == nil)
            {
                return
            }

            if(imageData == nil)
            {
                return
            }


            let body = NSMutableData()
            let fname = "image3.png"
            let mimetype = "image/png"

            body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
            body.append("Content-Disposition:form-data; name=\"test\"\r\n\r\n".data(using: String.Encoding.utf8)!)
            body.append("hi\r\n".data(using: String.Encoding.utf8)!)

            body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
            body.append("Content-Disposition:form-data; name=\"file\"; filename=\"\(fname)\"\r\n".data(using: String.Encoding.utf8)!)
            body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8)!)
            body.append(imageData!)
            body.append("\r\n".data(using: String.Encoding.utf8)!)

            body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)

            request.httpBody = body as Data
            //--------------------------------------------------------------------------------------------------------------------------------
              
            do
            {
                // passing the data to server here
                let uploadJob = URLSession.shared.uploadTask(with: request, from: request.httpBody)
                {
                    data, response, error in
                      
                    if error != nil
                    {
                          
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
                        if let unwrappedData = data
                        {
                            let returnedData = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue) // Response from web server hosting the database
                              
                            if returnedData == "1" // insert into database worked
                            {
                                
                            }
                            else
                            {
                                
                            }
                            print("---------------------")
                            print("response from php here ---->")
                            print(returnedData!)
                            
                            print("---------------------")
                            print("httpbody here ---->")
                        }
                    }
                }
                uploadJob.resume()
            }
            //-----------------------------------------------------------------------------------------------------------------------------------------------
            
        }
        else
        {
            //Error
        }
    }
    
    // select picture function
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    // function for upload picture to server
    func generateBoundaryString() -> String
    {
        return "Boundary-\(UUID().uuidString)"
    }
    
    
    
    //submit button action
    @IBAction func submit(_ sender: Any)
    {
        
        guard let license_number = license_number.text,
            let exp_date = exp_date,
            let license_photo = myimageview.image
        else {
            return
        }
        
            // upload license number and expired date
            let urls = URL(string: "http://cgi.soic.indiana.edu/~team05/insertlicense.php") // locahost MAMP - change to point to your database server
                      
            var request = URLRequest(url: urls!)
                request.httpMethod = "POST"
                      
                var dataString = "" // starting POST string with a secretWord
          
                // the POST string has entries separated by &
                dataString = dataString + "&license_number=\(license_number)"
                dataString = dataString + "&exp_date=\(exp_date.date)"
                dataString = dataString + "&license_photo=\(license_photo)"
                print(dataString)
                
                // convert the post string to utf8 format
                let dataD = dataString.data(using: .utf8) // convert to utf8 string
                  
                do
                {
                    // passing the data to server here
                    let uploadJob = URLSession.shared.uploadTask(with: request, from: dataD)
                    {
                        data, response, error in
                          
                        if error != nil
                        {
                              
                            // display an alert if there is an error inside the DispatchQueue.main.async
                            DispatchQueue.main.async
                            {
                                    let alert = UIAlertController(title: "Upload Didn't Work?", message: "Looks like the connection to the server didn't work.  Do you have Internet access?", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
                                        action in

                                            self.dismiss(animated: true, completion: nil)


                                    }))

                                        self.present(alert, animated: true, completion: nil)
                            }
                        }
                        else
                        {
                            if let unwrappedData = data
                            {
                                let returnedData = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue) // Response from web server hosting the database
                                  
                                if returnedData == "1" // insert into database worked
                                {
                                    // display an alert if no error and database insert worked (return = 1) inside the DispatchQueue.main.async
                                    DispatchQueue.main.async
                                    {
                                        let alert = UIAlertController(title: "license number was changed", message: "You had successfully changed your license.", preferredStyle: .alert)
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
                                        let alert = UIAlertController(title: "License Uploaded", message: "Your license was successfully uploaded.", preferredStyle: .alert)
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
                    
                    //resume code
                    uploadJob.resume()
                }
    }
}
          


