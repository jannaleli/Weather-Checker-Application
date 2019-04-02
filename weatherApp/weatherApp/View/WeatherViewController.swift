//
//  WeatherViewController.swift
//  weatherApp
//
//  Created by Jann Aleli Zaplan on 2/4/19.
//  Copyright © 2019 Jann Aleli Zaplan. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    var dataSource: Weather? = nil
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    @IBOutlet weak var table: UICollectionView!
    public func reload(){
        
        DispatchQueue.main.async {
              self.table.reloadData()
        }
   
    }
    func startProgress() {
        self.progressIndicator.startAnimating()
    }
    func stopProgress(){
        DispatchQueue.main.async {
            self.progressIndicator.isHidden = true
            self.progressIndicator.stopAnimating()
            self.countryLabel.isHidden = false
            self.countryLabel.text = self.dataSource?.city.name
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.startProgress()
        WeatherManager().getWeather( completionBlock: {data, error in
            self.dataSource = data as? Weather
         
            self.stopProgress()
            self.reload()
            
            })

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.dataSource == nil {
            return 0
            
        }
        print(self.dataSource!.list.count)
        return self.dataSource!.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionItemView", for: indexPath) as! CollectionViewCell
        let row = indexPath.item
        let epocTime = TimeInterval((self.dataSource?.list[row].dt)!)
        
        let myDate = Date(timeIntervalSince1970:  epocTime)
        let stringDate = myDate.description
        
        item.cloudLabel!.text = self.dataSource?.list[row].dt_txt
        item.descriptionLabel!.text = self.dataSource?.list[row].weather[0].description
        item.temperatureLabel!.text = self.dataSource?.list[row].main.temp_min.description
        return item
    }
    
    
}

extension WeatherViewController: UICollectionViewDelegate {
    
}

extension WeatherViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           var width: CGFloat? = self.table.frame.width
        return CGSize(width: width!, height: 50)
    }
}
