//
//  WeatherController.swift
//  weatherApp
//
//  Created by Jann Aleli Zaplan on 2/4/19.
//  Copyright © 2019 Jann Aleli Zaplan. All rights reserved.
//

import Foundation

public class WeatherManager {
    
    open func getWeather(completionBlock: @escaping CompletionBlock){
        NetworkManager().retrieveWeather(completionBlock: {
            data, error in
            
            if data != nil {
                
                do {
                    // data we are getting from network request
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Weather.self, from: data! as! Data)
                    print(response.city) //Output - EMT
                    completionBlock(response as AnyObject, nil)
                } catch { print(error) }
            }else{
                completionBlock(nil,nil)
            }
        
            
            
        })
    }
    
}
