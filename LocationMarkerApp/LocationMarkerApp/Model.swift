//
//  Model.swift
//  LocationMarkerApp
//
//  Created by Appinventiv Mac on 28/03/18.
//  Copyright © 2018 Appinventiv Mac. All rights reserved.
//

import Foundation

struct DistanceModel:Decodable {
    var rows:[Rows]
    var status:String
}

struct Rows:Decodable{
    var elements: [Elements]
}

struct Elements:Decodable {
    var distance:Distance
    var duration:Duration
}

struct Distance:Decodable{
    var text:String
}
struct Duration:Decodable {
    var text:String
}
