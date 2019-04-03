//
//  WeatherViewProtocol.swift
//  weatherApp
//
//  Created by Jann Aleli Zaplan on 3/4/19.
//  Copyright © 2019 Jann Aleli Zaplan. All rights reserved.
//

import Foundation
import UIKit

protocol WeatherViewControllerProtocol {
    func numberOfSections(in tableView: UITableView) -> Int
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
}
