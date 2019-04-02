//
//  NetworkManager.swift
//  weatherApp
//
//  Created by Jann Aleli Zaplan on 2/4/19.
//  Copyright © 2019 Jann Aleli Zaplan. All rights reserved.
//

import Foundation

public typealias CompletionBlock = (_ result: AnyObject?, _ error: NSError?) -> Void
public class NetworkManager {
    
    public func retrieveWeather(completionBlock: @escaping CompletionBlock){
        //Singapore City ID
        let apiURL = URL(string: "https://samples.openweathermap.org/data/2.5/forecast?id=1880252&appid=b6907d289e10d714a6e88b30761fae22")
        
        let task = URLSession.shared.dataTask(with: apiURL!) { data, response, error in
            if error != nil {
                completionBlock(nil,nil)
            }else{
            
                completionBlock(data as AnyObject, nil)
                
                
            }
         
            
        }
        task.resume()
    }
    
    
    
}
