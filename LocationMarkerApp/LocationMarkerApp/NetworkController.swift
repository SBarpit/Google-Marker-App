//
//  NetworkController.swift
//  LocationMarkerApp
//
//  Created by Appinventiv Mac on 29/03/18.
//  Copyright © 2018 Appinventiv-Mac. All rights reserved.
//


import Foundation

class NetworkController {
    
    func getTime(Url:String,header:[String:Any]=[String:Any](),success:@escaping (DistanceModel)->()) {
        
        let request = NSMutableURLRequest(url: NSURL(string: Url)! as URL,cachePolicy: .useProtocolCachePolicy,timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request as URLRequest , completionHandler: { (data, response, error) -> Void in
            
            if let e=error{
                print(e)
            } else {
                let httpResponse = response as! HTTPURLResponse
                print(httpResponse)
            }
            
            guard let d = data else {return}
            do {
                //MARK: DECODING
                let model = try JSONDecoder().decode(DistanceModel.self, from: d)
                //here we are decoding data to model.
                success(model)
            }
            catch let error as NSError {
                print("Could not fetch data. \(error), \(error.userInfo)")
            }
        }).resume()
    }
}

