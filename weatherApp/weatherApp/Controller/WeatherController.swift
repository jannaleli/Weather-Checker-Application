//
//  WeatherController.swift
//  weatherApp
//
//  Created by Jann Aleli Zaplan on 2/4/19.
//  Copyright © 2019 Jann Aleli Zaplan. All rights reserved.
//

import Foundation
import CoreData
import AlamofireImage
import Alamofire

public class WeatherManager {
    
    open func saveUserDefaults(response: AnyObject){

            UserDefaults.standard.set(response , forKey: "Weather")
        
        
    }
    
    
    open func readUserDefaults() -> Codable? {
        if
        let data = UserDefaults.standard.value(forKey: "Weather") as? Data,
        let configuration = try? JSONDecoder().decode(Weather.self, from: data) {
            return configuration
        }
        return nil
        
    }
    
    open func getWeather(completionBlock: @escaping CompletionBlock){
        NetworkManager().retrieveWeather(completionBlock: {
            data, error in
            
            if data != nil {
                
                do {
                    // data we are getting from network request
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Weather.self, from: data! as! Data)
                    self.saveUserDefaults(response: data!)
                    
                    
                    print(response.city) //Output - EMT
                    completionBlock(response as AnyObject, nil)
                } catch { print(error) }
            }else{
                completionBlock(nil,nil)
            }
        
            
            
        })
    }
    
    
    func sendRequestForImage(url: String, completionBlock:@escaping CompletionBlock) {
        Alamofire.request(url).responseImage { response in
            
            print(response)
            guard response.result.isSuccess else {
                completionBlock(nil, nil)
                return
            }
            
            if let image = response.result.value {
                print("image downloaded: \(image)")
                completionBlock(image, nil)
            }
        }
    }
    
    
}
