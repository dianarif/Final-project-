//
//  reservationViewController.swift
//  CarMa
//
//  Created by Tianze Huang on 3/7/20.
//  Copyright © 2020 Dianprakasa, Arif. All rights reserved.
//

import UIKit
extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

class reservationViewController: UIViewController
{

    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    
    var image = URL(string: "")
    var name = ""
    var rate = ""
    
    var account_fname = ""
    var account_lname = ""
    
    @IBOutlet weak var pickuptime: UIDatePicker!
    @IBOutlet weak var dropofftime: UIDatePicker!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        lbl.text = "You selected \(name) for your car."
        img.downloadImage(from: image!)
        // Do any additional setup after loading the view.
    }
    

    @IBAction func button(_ sender: Any)
    {
        // to the next view controller
        let vcc = storyboard?.instantiateViewController(withIdentifier: "paypalViewController") as? paypalViewController
        vcc?.pickup_time = pickuptime.date.toString(dateFormat: "yyyy/MM/dd HH:mm:ss")
        vcc?.dropoff_time = dropofftime.date.toString(dateFormat: "yyyy/MM/dd HH:mm:ss")
        vcc?.rate = Double(rate) ?? 0
        
        vcc?.select = name
        vcc?.account_fname = account_fname
        vcc?.account_lname = account_lname
        
        self.navigationController?.pushViewController(vcc!, animated: true)
    }
    

}
