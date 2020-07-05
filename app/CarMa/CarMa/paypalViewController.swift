//
//  paypalViewController.swift
//  CarMa
//
//  Created by Emily Oneal on 3/4/20.
//  Copyright © 2020 Dianprakasa, Arif. All rights reserved.
//

import UIKit
import Braintree

class paypalViewController: UIViewController
{
    var braintreeClient: BTAPIClient?
    
    //labels in the storyboard
    @IBOutlet weak var hourly_rate: UILabel!
    @IBOutlet weak var sales_tax: UILabel!
    @IBOutlet weak var auto_exercise: UILabel!
    @IBOutlet weak var totalcost: UILabel!
    @IBOutlet weak var pick_up_time: UILabel!
    @IBOutlet weak var drop_off_time: UILabel!
    @IBOutlet weak var selection: UILabel!
    
    //variables from reservation view controller
    var paypalamount = ""
    var pickup_time = ""
    var dropoff_time = ""
    var select = ""
    var rate = 11.5
    
    var account_fname = ""
    var account_lname = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        print(account_fname + " " + account_lname)
        
        braintreeClient = BTAPIClient(authorization: "sandbox_9q33q3sd_v742c2q26cwjfvx8")!
        
        var total_cost = 0.00
        var salestax = 0.00
        var autoexercise = 0.00
        
        var pickup_hour = 0
        var dropoff_hour = 0
        var pickup_min = 0
        var dropoff_min = 0
        
        let name = selection
        
        let pick_up = pickup_time.suffix(8)
        let drop_off = dropoff_time.suffix(8)
        
        var pickup_date = pickup_time.prefix(10)
        var dropoff_date = dropoff_time.prefix(10)
        
        if pickup_date == dropoff_date
        {
            dropoff_hour = Int(drop_off.prefix(2)) ?? 0
            pickup_hour = Int(pick_up.prefix(2)) ?? 0
            
            pickup_min = Int(pick_up[pick_up.index(pick_up.startIndex, offsetBy: 3)..<pick_up.index(pick_up.endIndex, offsetBy: -3)]) ?? 0
            dropoff_min = Int(drop_off[drop_off.index(drop_off.startIndex, offsetBy: 3)..<drop_off.index(drop_off.endIndex, offsetBy: -3)]) ?? 0
            
            total_cost = Double((dropoff_hour * 60 + dropoff_min) - (pickup_hour * 60 + pickup_min)) / 60 * rate
            salestax = round(total_cost * 0.1 * 100)/100
            autoexercise = round(total_cost * 0.05 * 100)/100
            
            selection.text! =  "Vehicle selected: " + String(select)
            pick_up_time.text! = String(pickup_time)
            drop_off_time.text! = String(dropoff_time)
            hourly_rate.text! = "$ " + String(total_cost) + "0"
            sales_tax.text! = "$ " + String(salestax) + "0"
            auto_exercise.text! = "$ " + String(autoexercise)
            totalcost.text! = "$ " + String(round((total_cost + salestax + autoexercise) * 100)/100)
            
            paypalamount = String(total_cost + salestax + autoexercise)
            print(paypalamount)
        }
        else
        {
            let daypick = Int(pickup_date.suffix(2)) ?? 0
            let daydrop = Int(dropoff_date.suffix(2)) ?? 0
            
            let monthpick = Int(pickup_date[pickup_date.index(pickup_date.startIndex, offsetBy: 5)..<pickup_date.index(pickup_date.endIndex, offsetBy: -3)]) ?? 0
            let monthdrop = Int(dropoff_date[dropoff_date.index(dropoff_date.startIndex, offsetBy: 5)..<dropoff_date.index(dropoff_date.endIndex, offsetBy: -3)]) ?? 0
            
            let yearpick = Int(pickup_date.prefix(4)) ?? 0
            let yeardrop = Int(dropoff_date.prefix(4)) ?? 0
            
            let total_days = (yeardrop * 365 + monthdrop * 30 + daydrop) - (yearpick * 365 + monthpick * 30 + daypick)
            
            if total_days == 1
            {
                total_cost = Double((dropoff_hour * 60 + dropoff_min) + (24 * 60 - pickup_hour * 60 + pickup_min)) / 60 * rate
                salestax = round(total_cost * 0.1 * 100)/100
                autoexercise = round(total_cost * 0.05 * 100)/100
                
                selection.text! =  "Vehicle selected: " + String(select) 
                pick_up_time.text! = String(pickup_time)
                drop_off_time.text! = String(dropoff_time)
                hourly_rate.text! = "$ " + String(total_cost) + "0"
                sales_tax.text! = "$ " + String(salestax) + "0"
                auto_exercise.text! = "$ " + String(autoexercise) + "0"
                totalcost.text! = "$ " + String(round((total_cost + salestax + autoexercise) * 100)/100) + "0"
                
                paypalamount = String(total_cost + salestax + autoexercise)
            }
            else
            {
                total_cost = Double(total_days * 24) * rate
                salestax = round(total_cost * 0.1 * 100)/100
                autoexercise = round(total_cost * 0.05 * 100)/100
                
                hourly_rate.text! = "$ " + String(total_cost) + "0"
                sales_tax.text! = "$ " + String(salestax) + "0"
                auto_exercise.text! = "$ " + String(autoexercise) + "0"
                totalcost.text! = "$ " + String(round((total_cost + salestax + autoexercise) * 100)/100) + "0"
                
                paypalamount = String(total_cost + salestax + autoexercise)
            }
        }
    }
    
    @IBAction func clickedBtnPay(_ sender: Any)
    {
        
         guard let braintreeClient = braintreeClient
            else {
             return
         }
                
            let payPalDriver = BTPayPalDriver(apiClient: braintreeClient)
            payPalDriver.viewControllerPresentingDelegate = self
            payPalDriver.appSwitchDelegate = self // Optional

            // Specify the transaction amount here. "2.32" is used in this example.
            let request = BTPayPalRequest(amount: paypalamount)
            request.currencyCode = "USD" // Optional; see BTPayPalRequest.h for more options

            payPalDriver.requestOneTimePayment(request) { (tokenizedPayPalAccount, error) in
                if let tokenizedPayPalAccount = tokenizedPayPalAccount {
                    print("Got a nonce: \(tokenizedPayPalAccount.nonce)")

                    // Access additional information
                    let email = tokenizedPayPalAccount.email
                    let firstName = tokenizedPayPalAccount.firstName
                    let lastName = tokenizedPayPalAccount.lastName
                    let phone = tokenizedPayPalAccount.phone

                    // See BTPostalAddress.h for details
                    let billingAddress = tokenizedPayPalAccount.billingAddress
                    let shippingAddress = tokenizedPayPalAccount.shippingAddress
                } else if let error = error {
                    print(error)
                } else {
                    // Buyer canceled payment approval
                }
            }
    }
}

//paypal
extension paypalViewController : BTViewControllerPresentingDelegate
{
       func paymentDriver(_ driver: Any, requestsPresentationOf viewController: UIViewController)
       {
           present(viewController, animated: true, completion: nil)
            
       }

       func paymentDriver(_ driver: Any, requestsDismissalOf viewController: UIViewController)
       {
           viewController.dismiss(animated: true, completion: nil)
       }

}

//paypal
extension paypalViewController : BTAppSwitchDelegate
{
   func appSwitcherWillPerformAppSwitch(_ appSwitcher: Any)
   {
       

   }
   
   func appSwitcher(_ appSwitcher: Any, didPerformSwitchTo target: BTAppSwitchTarget)
   {

   }

   func appSwitcherWillProcessPaymentInfo(_ appSwitcher: Any)
   {
       
   }
}
    
   
    


