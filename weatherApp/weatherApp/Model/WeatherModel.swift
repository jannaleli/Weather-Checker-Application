//
//  WeatherModel.swift
//  weatherApp
//
//  Created by Jann Aleli Zaplan on 2/4/19.
//  Copyright © 2019 Jann Aleli Zaplan. All rights reserved.
//

import Foundation

struct Weather: Codable {
 
        struct List: Codable {
            struct Main : Codable {
                let temp: Double
                let temp_min: Double
                let temp_max: Double
                let pressure: Double
                let sea_level: Double
                let grnd_level: Double
                let humidity: Double
                let temp_kf: Double
                
            }
            struct Weather : Codable {
                let id: Int
                let main: String
                let description: String
                let icon:String
            }
            struct Clouds: Codable {
                let all: Int
            }
            struct Wind : Codable {
                let speed: Double
                let deg: Double
            }
            struct Sys: Codable {
                let pod: String
            }
            let dt_txt: String
            let dt: Int
            let sys: Sys
            let main: Main
            let weather: [Weather]
            let clouds: Clouds
            let wind: Wind
        }
        
        struct City: Codable {
            struct Coord: Codable {
                let lon: Double
                let lat: Double
            }
            let coord: Coord
            let country: String
            let id: Double
            let name: String
        }

        
        
    
        let cod: String
        let cnt: Int
        let list: [List]
        let city: City
    
    
}
