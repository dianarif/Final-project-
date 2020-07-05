 //
 //  mapViewController.swift
 //  CarMa
 //
 //  Created by Emily Oneal on 4/2/20.
 //  Copyright © 2020 Dianprakasa, Arif. All rights reserved.
 //

 import UIKit
 import GoogleMaps
   
 class mapViewController: UIViewController, GMSMapViewDelegate {
      
     override func loadView() {
         
         let camera = GMSCameraPosition.camera(withLatitude: 39.169430, longitude: -86.522880, zoom: 15.0)
          let mapView = GMSMapView.map(withFrame: CGRect(x: 20, y: 100, width: 380, height: 280), camera: camera)
        mapView.delegate = self
                 self.view = mapView
         let marker1 = GMSMarker()
         marker1.position = CLLocationCoordinate2D(latitude: 39.164291, longitude: -86.526848)
         marker1.title = "Henderson-Atwater Parking Garage"
         marker1.snippet = "301 S Indiana Ave, Bloomington, IN 47401"
         marker1.map = mapView
         
          let marker2 = GMSMarker()
                marker2.position = CLLocationCoordinate2D(latitude: 39.169430, longitude: -86.522880)
                marker2.title = "IMU Parking Lot"
                marker2.snippet = "918-938 E 8th St, Bloomington, IN 47405"
                marker2.map = mapView
         
          let marker3 = GMSMarker()
          marker3.position = CLLocationCoordinate2D(latitude: 39.164188, longitude: -86.498932)
          marker3.title = "College Mall"
          marker3.snippet = "2894 E 3rd St, Bloomington, IN 47401"
         marker3.map = mapView
       
        
        
          }

    
     func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print("tapped on marker")
         performSegue(withIdentifier: "tapmarker", sender: self)
        if marker.title == "Me"{
            print("handle specific marker")
        }
        return true
    }
          
     

         
     



 }

