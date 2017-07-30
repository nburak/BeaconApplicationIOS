//
//  ViewController.swift
//  BeaconApplication
//
//  Created by Nuh Burak Karakaya on 22.07.2017.
//  Copyright © 2017 bk. All rights reserved.
//


/*
    
 Developed By Nuh Burak Karakaya. 
 Project was Licanced with GPL. 
 Available for Personal Usage. 
 Permission must be obtained for Commercial Usage.
 for contact please send an email to burakkarakaya10@gmail.com
 
 
 
*/

import UIKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {

    @IBOutlet weak var txtPerm: UITextView!
    @IBOutlet weak var imgLogo: UIImageView!
    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: NSUUID(uuidString: "YOUR_BEACON_UUID") as! UUID,identifier: "Estimotes")
    
    @IBOutlet weak var txtInfo: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgLogo.center.y = imgLogo.frame.size.height/2 + 20
        txtPerm.center.y = imgLogo.center.y + (imgLogo.frame.size.height + txtPerm.frame.size.height)/2

        locationManager.delegate = self
        
        if(CLLocationManager.authorizationStatus() != CLAuthorizationStatus.authorizedWhenInUse)
        {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startRangingBeacons(in: region)
        txtInfo.center = view.center
        txtPerm.center.x = view.center.x
        imgLogo.center.x = view.center.x
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion)
    {
        
        if(beacons.first?.proximity == nil)
        {
            txtInfo.text="Couldn't find it!"
            view.backgroundColor = UIColor.gray
            return
        }
        
        if(String(describing: beacons.first!.major) + ":" + String(describing: beacons.first!.minor) == "0:0")
        {
            view.backgroundColor = UIColor.blue
            txtInfo.text=String(describing: beacons.first!.major) + ":" + String(describing: beacons.first!.minor)
            
        }
        else if(String(describing: beacons.first!.major) + ":" + String(describing: beacons.first!.minor) == "1:1")
        {
            view.backgroundColor = UIColor.red
            txtInfo.text = String(describing: beacons.first!.major) + ":" + String(describing: beacons.first!.minor)
        }
        else
        {
            view.backgroundColor = UIColor.yellow
            txtInfo.text = "Foreign Beacon: " + String(describing: beacons.first!.major) + ":" + String(describing: beacons.first!.minor)
        }
        
    }

    
}

