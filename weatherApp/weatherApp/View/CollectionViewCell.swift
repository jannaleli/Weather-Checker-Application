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
}
