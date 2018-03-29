//
//  APIController.swift
//  SwiftyJSONModel
//
//  Created by Appinventiv-Mac on 21/03/18.
//  Copyright © 2018 Appinventiv-Mac. All rights reserved.
//


import Foundation
import UIKit

class APIController {
    
    func getTime(modes:String,sourcelat:Double,sourcelng:Double,destlat:Double,destlng:Double,success:@escaping (DistanceModel)->()) {
    
        let timeURL = "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=\(sourcelat),\(sourcelng)&destinations=\(destlat),\(destlng)&mode=\(modes)&key=AIzaSyBXSZOOoR3kNLHEy1maOLnJzrUoGZRgAIM"
        
        NetworkController().getTime(Url: timeURL) { (distances) in
            success(distances)
        }
    
    }
    
}
