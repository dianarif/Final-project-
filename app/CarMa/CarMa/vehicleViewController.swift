//
//  vehicleViewController.swift
//  CarMa
//
//  Created by Tianze Huang on 3/6/20.
//  Copyright © 2020 Dianprakasa, Arif. All rights reserved.
//

import UIKit
import GoogleMaps

extension UIImageView
{
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ())
    {
       URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL)
    {
       getData(from: url) {
          data, response, error in
          guard let data = data, error == nil else {
             return
          }
          DispatchQueue.main.async() {
             self.image = UIImage(data: data)
          }
       }
    }
}


class vehicleViewController: UIViewController, GMSMapViewDelegate, UITableViewDelegate, ConnectVehicleProtocol
{
    
    var name = ["s", "x", "y"]

    @IBOutlet weak var tableView: UITableView!
        
    //Properties
    var feedItems: NSArray = NSArray()
    var selectedLocation : vehicleModel = vehicleModel()
    var vehicle1 = ""
    var vehicle2 = ""
    
    var account_fname = ""
    var account_lname = ""
    
    //set delegates and initialize homeModel from vehicle model
    let vModel = ConnectVehicle()
    
    func itemsDownload(items: NSArray)
    {
        feedItems = items
        self.tableView.reloadData()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        vModel.delegate = self
        vModel.downloadItems()
        

    }
  
    

}

extension vehicleViewController: UITableViewDataSource
{

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 180
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return feedItems.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        //Retrieve cell
        let cellIdentifier: String = "cell"
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CellTableViewCell
        
        //Gt location to be shown
        let item: vehicleModel = feedItems[indexPath.row] as! vehicleModel
        
        let url = URL(string: item.photo!)
        
        //Get reference to labels of cell
        cell?.img.downloadImage(from: url!)
        cell?.lbl.text = "Model: " + item.model!
        cell?.rate.text = "Rate: $" + item.rate! + " / hour"
        cell?.features.text = item.features
        return cell!
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "reservationViewController") as? reservationViewController
        let item: vehicleModel = feedItems[indexPath.row] as! vehicleModel
        
        vc?.image = URL(string: item.photo!)
        vc?.name = item.model!
        vc?.rate = item.rate!
        
        vc?.account_fname = account_fname
        vc?.account_lname = account_lname
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
}
