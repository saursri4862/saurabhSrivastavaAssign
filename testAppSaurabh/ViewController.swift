//
//  ViewController.swift
//  testAppSaurabh
//
//  Created by Turvo on 27/08/18.
//  Copyright © 2018 Turvo. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var places = [Places]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        getData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func getData(){
        
        let urlString = "http://www.mocky.io/v2/5b83aaf63100004a000d2008"
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        
        Alamofire.request(urlString).responseString{ response in
            let string = response.result.value
            print(string)
            let data = string?.data(using: .utf8)!
            do {
                if let json = try JSONSerialization.jsonObject(with: data!) as? [[String: Any]]{
                    print(json)
                    for dict in json{
                        var place = Places()
                        place.updatePlaces(dict)
                        self.places.append(place)
                    }
                    DispatchQueue.main.async {
                        self.updateNewPointer()
                    }
                    
            }
            } catch let error as NSError {
                print(error)
            }
        }
    }
    

    func updateNewPointer(){
       mapView.showAnnotations(places, animated: true)
    
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if (annotation is MKUserLocation) {
            return nil
        }
        
        let reuseId = "testApp"
        
        var anView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        let place = getPlaces(annotation)
        if anView == nil {
            anView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView?.canShowCallout = true
        }
        else {
            anView?.annotation = annotation
        }
        
        return anView
    }
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let place = getPlaces(view.annotation!)
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "LocationDetailsViewController") as! LocationDetailsViewController
        controller.place = place
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func getPlaces(_ anno:MKAnnotation) -> Places{
        for place in places{
             if place.coordinate.latitude == anno.coordinate.latitude && place.coordinate.longitude == anno.coordinate.longitude{
                return place
            }
        }
        return Places()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

