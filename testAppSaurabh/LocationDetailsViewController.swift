//
//  LocationDetailsViewController.swift
//  testAppSaurabh
//
//  Created by Turvo on 27/08/18.
//  Copyright © 2018 Turvo. All rights reserved.
//

import UIKit
import Kingfisher

class LocationDetailsViewController: UIViewController {

    @IBOutlet weak var locCoordi: UILabel!
    @IBOutlet weak var locAddress: UILabel!
    @IBOutlet weak var locName: UILabel!
    @IBOutlet weak var locImage: UIImageView!
    var place:Places!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if place != nil{
            locAddress.text = place.address
            locName.text = place.title!
            locImage.kf.setImage(with: URL(string:place.image))
            locCoordi.text = String(place.lat)+","+String(place.lng)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
