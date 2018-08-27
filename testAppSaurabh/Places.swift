//
//  Places.swift
//  testAppSaurabh
//
//  Created by Turvo on 27/08/18.
//  Copyright © 2018 Turvo. All rights reserved.
//

import UIKit
import MapKit

class Places: NSObject , MKAnnotation{
    var title:String?
    var address = ""
    var lat:Double = 0.0
    var lng:Double = 0.0
    var image = ""
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    
    
    func updatePlaces(_ data:[String:Any]){
        if let str = data["name"] as? String{
            title = str
        }
        if let str = data["address"] as? String{
            address = str
        }
        if let str = data["image"] as? String{
            image = str
        }
        if let doy = data["lat"] as? Double{
            lat = doy
            coordinate.latitude = lat
        }
        if let doy = data["lng"] as? Double{
            lng = doy
            coordinate.longitude = lng
        }
    
    }

}
