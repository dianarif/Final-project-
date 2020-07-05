//
//  GSigninViewController.swift
//  CarMa
//
//  Created by Emily Oneal on 2/16/20.
//  Copyright © 2020 Dianprakasa, Arif. All rights reserved.
//

import UIKit
import GoogleSignIn

class GSigninViewController: UIViewController, GIDSignInDelegate, BaseconnectionProtocol{
    
      @IBOutlet weak var lblTitle:UILabel!
      @IBOutlet weak var btnGoogleSignIn:UIButton!

      //Properties
      var feedItems: NSArray = NSArray()
      var selectedLocation : UserModel = UserModel()
    
      var loginemail = ""
      var checkemail = false
    
      override func viewDidLoad()
      {
            super.viewDidLoad()
        
            //set delegates and initialize homeModel
            let homeModel = Baseconnection()
            homeModel.delegate = self
            homeModel.downloadItems()
        
            // Do any additional setup after loading the view, typically from a nib.
            btnGoogleSignIn.addTarget(self, action: #selector(signinUserUsingGoogle(_ :)), for: .touchUpInside)
        
      }
    
    @IBAction func btnGoogleSignIn(_ sender: Any)
    {
        
    }

        override func didReceiveMemoryWarning()
        {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
    
    
        @objc func signinUserUsingGoogle(_ sender: UIButton)
        {
            if btnGoogleSignIn.title(for: .normal) == "Sign Out"
            {
                GIDSignIn.sharedInstance().signOut()
                lblTitle.text = ""
                btnGoogleSignIn.setTitle("Sign In using Google", for: .normal)
            }
            else
            {
                GIDSignIn.sharedInstance().delegate = self
                GIDSignIn.sharedInstance().presentingViewController = self
                GIDSignIn.sharedInstance().signIn()
            }
        }

    
        
        func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!)
        {
            
            if let error = error
            {
                print("We have error sign in user == \(error.localizedDescription)")
            }
            else
            {
                if let gmailUser = user
                {
                    // use while loop to check data one at a time
                    var index = 0
                    while index < feedItems.count
                    {
                        let item: UserModel = feedItems[index] as! UserModel
                        
                        if gmailUser.profile.email! == item.email!
                        {
                            //blTitle.text = "You are signed in as \(item.email!)"
                            //btnGoogleSignIn.setTitle("Sign Out", for: .normal)
                            
                            // pass email to account page
                            loginemail = item.email!
                            checkemail = true
                            
                            // go to the account page using segue
                            performSegue(withIdentifier: "signintoaccount", sender: self)
                            break;
                        }
                        // test print in console below
                        print(item.email!)
                        
                        //display the result in the storyboard
                        //output.text! += item.first_name! + item.last_name! + item.email!
                        
                        if index == feedItems.count - 1
                        {
                            if gmailUser.profile.email! != item.email!
                            {
                                //lblTitle.text = "You don't have an account with carma, INSERT SIGNUP PAGE HERE"
                                
                                // go to sign up new user page using segue
                                performSegue(withIdentifier: "newuser", sender: self)
                                break;
                            }
                        }
                        
                        // increment index
                        index = index + 1
                    }
                    
                    //
                    if checkemail
                    {
                        print("email checked: " + loginemail)
                    }
                }
            }
        }
    
    //TRIGGERS THIS FUNCTION EVERYTIME PERFORM SEGUE IS CALLED
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "signintoaccount"
        {
            var vc = segue.destination as! ViewController
            vc.emailfromlogin = self.loginemail
            print("segue execeuted")
        }
        else
        {
            var vc = segue.destination as! newUserViewController
        }
    }
    
    // sth to do with baseconnectionprotocol TO DOWNLOAD PHP
        func itemsDownloaded(items: NSArray)
        {
            feedItems = items
        }

    }
