//
//  ViewController.swift
//  LocationMarkerApp
//
//  Created by Appinventiv-Mac on 28/03/18.
//  Copyright © 2018 Appinventiv-Mac. All rights reserved.
//

//AIzaSyBXSZOOoR3kNLHEy1maOLnJzrUoGZRgAIM

//POINTS
//Point 1: 315 West 36th Street, New York, NY 10018
//Point 2: 48-19 Vernon Blvd, Long Island City, NY 11101
//Point 3: 178 Broadway, Brooklyn, NY 11211
//Point 4: 285 Fulton St, New York, NY 10007

//LAT-LONG
//40.45146052
//-73.9933561
//40.7434825
//-73.9535474
//40.7097529
//-73.9624787
//40.7130082
//-74.0153576

import UIKit
import GoogleMaps

class ViewController: UIViewController {
    
    @IBOutlet weak var t1: UILabel!
    @IBOutlet weak var t2: UILabel!
    @IBOutlet weak var t3: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var slidingView: UIView!
    @IBOutlet weak var naviBT: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var b4: UIButton!
    
    
    var distances:DistanceModel?
    let pointAlat = 40.45146052
    let pointAlng = -73.9933561
    let pointBlat = 40.7434825
    let pointBlng = -73.9535474
    let pointClat = 40.7097529
    let pointClng = -73.9624787
    let pointDlat = 40.7130082
    let pointDlng = -74.0153576
    var toggle=false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.naviBT.layer.cornerRadius = self.naviBT.bounds.size.width/2
        circleBT(self.b1)
        circleBT(self.b2)
        circleBT(self.b3)
        circleBT(self.b4)
        let camera = GMSCameraPosition.camera(withLatitude:  pointAlat, longitude: pointAlng, zoom: 9.0)
        mapView.camera = camera
        showMarker(position: camera.target)
        self.calculete("driving")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func goToButtonTapped(_ sender: UIButton) {
        self.openMap(withSourceLocation: pointAlat, sLong: pointAlng, withDestinationLocation: pointBlat, dLong: pointBlng)
    }
    
    @IBAction func byTrain(_ sender: UIButton) {
        
        let mode = "transit&transit_mode=train"
        self.calculete(mode)
    }
    @IBAction func byWalking(_ sender: UIButton) {
        let mode = "walking"
        self.calculete(mode)

    }
    @IBAction func byCycle(_ sender: UIButton) {
        let mode = "bicycling"
        self.calculete(mode)

    }
    @IBAction func byCar(_ sender: UIButton) {
        let mode = "driving"
        self.calculete(mode)

    }
    @IBAction func actionBT(_ sender: UIButton) {
        if !self.toggle{
            self.toggle = !self.toggle
            UIView.animate(withDuration: 1.0, animations: {
                self.slidingView.transform = CGAffineTransform(translationX: 0, y: 130)
            })
        }else{
            self.toggle = !self.toggle
            UIView.animate(withDuration: 1.0, animations: {
                self.slidingView.transform = CGAffineTransform(translationX: 0, y: -130)
            })
        }
    }
    
    
}

extension ViewController {
   
    func showMarker(position: CLLocationCoordinate2D){
        
        let marker1 = GMSMarker()
        marker1.position = CLLocationCoordinate2D(latitude: pointAlat, longitude: pointAlng)
        marker1.title = "A"
       // marker1.snippet = "San Francisco"
        mapView.selectedMarker = marker1
        marker1.map = mapView
        
        let marker2 = GMSMarker()
        marker2.position = CLLocationCoordinate2D(latitude: pointBlat, longitude: pointBlng)
        marker2.title = "B"
       // marker2.snippet = "San Francisco"
        mapView.selectedMarker = marker2
        marker2.map = mapView
        
        let marker3 = GMSMarker()
        marker3.position = CLLocationCoordinate2D(latitude: pointClat, longitude: pointClng)
        marker3.title = "C"
       // marker3.snippet = "San Francisco"
        mapView.selectedMarker = marker3
        marker3.map = mapView
        
        let marker4 = GMSMarker()
        marker4.position = CLLocationCoordinate2D(latitude: pointDlat, longitude: pointDlng)
        marker4.title = "D"
        //marker4.snippet = "San Francisco"
        mapView.selectedMarker = marker4
        marker4.map = mapView
        
    }
}

extension ViewController {
    
    private func openMap(withSourceLocation sLat : Double,
                         sLong : Double,
                         withDestinationLocation dLat : Double,
                         dLong : Double) {
        
        var url : URL!
        
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {//Check if application can open google maps
            
            guard let googleUrl = URL(string: "comgooglemaps://?saddr=\(sLat),\(sLong)&daddr=\(dLat),\(dLong)&directionsmode=traffic") else{
                return
            }
            
            url = googleUrl
        } else if (UIApplication.shared.canOpenURL(URL(string:"http://maps.apple.com")!)) {
            guard let appleUrl = URL(string: "http://maps.apple.com/?daddr=\(dLat),\(dLong)&saddr=\(sLat),\(sLong)") else{
                return
            }
            
            url = appleUrl
            
        } else {
            NSLog("Can't use Apple Maps");
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
        } else {
            // Fallback on earlier versions
            UIApplication.shared.openURL(url)
        }
    }
    
    func calculete(_ modes:String){
    
    APIController().getTime(modes:modes,sourcelat: pointAlat, sourcelng: pointAlng, destlat: pointBlat, destlng: pointBlng) { (distance) in
    let time=distance.rows[0].elements[0].duration.text
    print(time)
    let distance=distance.rows[0].elements[0].distance.text
    print(distance)
    DispatchQueue.main.async {
    self.t1.text = "\(time) \((distance))"
    }
    }
    
    APIController().getTime(modes:modes,sourcelat: pointBlat, sourcelng: pointBlng, destlat: pointClat, destlng: pointClng) { (distance) in
    let time=distance.rows[0].elements[0].duration.text
    print(time)
    let distance=distance.rows[0].elements[0].distance.text
    print(distance)
    DispatchQueue.main.async {
    self.t2.text = "\(time) \((distance))"
    }
    }
    
    APIController().getTime(modes:modes,sourcelat: pointClat, sourcelng: pointClng, destlat: pointDlat, destlng: pointDlng) { (distance) in
    let time=distance.rows[0].elements[0].duration.text
    print(time)
    let distance=distance.rows[0].elements[0].distance.text
    print(distance)
    DispatchQueue.main.async {
    self.t3.text = "\(time) \((distance))"
    }
}
}
}
extension ViewController{
    func circleBT(_ btn : UIButton){
        btn.layer.cornerRadius = btn.bounds.size.height/2
    }
}
