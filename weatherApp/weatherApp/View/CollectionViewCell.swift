//
//  CollectionViewCell.swift
//  weatherApp
//
//  Created by Jann Aleli Zaplan on 2/4/19.
//  Copyright © 2019 Jann Aleli Zaplan. All rights reserved.
//

import Foundation
import UIKit
open class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var temperatureLabel: UILabel?
    @IBOutlet weak var cloudLabel: UILabel?
    @IBOutlet weak var descriptionLabel: UILabel?
    static let nibName = "CollectionViewCell"
    static let cellReuseIdentifier = "CollectionViewCell"
    enum WeatherState {
        case error(String)
        case information(String, String, String)
    }
    
    func configureWith(kind: WeatherState){
        switch kind {
        case .error(let message):
            temperatureLabel?.text = "Error Loading"
            cloudLabel?.text = "Error Loading"
            descriptionLabel?.text = "Error Loading"
        case .information(let temperature, let cloud, let description):
            temperatureLabel?.text = temperature
            cloudLabel?.text = cloud
            descriptionLabel?.text = description
        }
    }
}
