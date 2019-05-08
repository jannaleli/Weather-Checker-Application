//
//  WeatherViewController.swift
//  weatherApp
//
//  Created by Jann Aleli Zaplan on 2/4/19.
//  Copyright © 2019 Jann Aleli Zaplan. All rights reserved.
//

import UIKit

class WeatherViewController: UICollectionViewController {
    var dataSource: Weather? = nil
     let refreshControl = UIRefreshControl()
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!

    
    
    enum WeatherState {
        case loading(Bool)
        case loaded(Weather)
        case empty
        case error(Error)
    }
    
    fileprivate var state: WeatherState = .loading(false) {
        didSet {
            collectionView.reloadData()
            switch state {
            case .error(_), .loaded(_):
                refreshControl.endRefreshing()
            default: break
            }
        }
    }
    
     @IBAction func refreshPulled(_ sender: UIRefreshControl){
        
        switch state {
        case .loading(_):
            return
        default:
            loadWeather(fromRefreshControl: true)
        }
   
    }
    
    
    private func loadWeather(fromRefreshControl: Bool){
        state = .loading(fromRefreshControl)
        self.setDataSource()
    }
    
    private func configureTableView() {
        collectionView.register(UINib(nibName: CollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: CollectionViewCell.cellReuseIdentifier)
        collectionView.register(UINib(nibName: RefreshViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: RefreshViewCell.cellReuseIdentifier)
        
    }
    private func setDataSource() {
        WeatherManager().getWeather( completionBlock: {data, error in
        
            
            if error == nil {
                
                let initialData = data as? Weather
                
                if initialData?.list.count == 0 {
                    self.state = .empty
                }else{
                    self.state = .loaded(initialData!)
                }
              
                
                
            }
            
        })

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadWeather(fromRefreshControl: false)
        
        
        
        refreshControl.tintColor = .blue
        refreshControl.addTarget(self, action: #selector(refreshPulled), for: .valueChanged)
        collectionView.addSubview(refreshControl)
        collectionView.alwaysBounceVertical = true
        
        
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

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension WeatherViewController {
  
     override   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            switch state {
            case .loaded(let weather):
                return weather.list.count
            case .empty, .error(_):
                return 1
            case .loading (let refreshFromControl):
                return refreshFromControl ? 0 : 1
            }
        }

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch state {
            
        case .loaded(let weather):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.cellReuseIdentifier, for: indexPath) as! CollectionViewCell
            cell.configureWith(kind: .information(weather.city.name, weather.cod, weather.city.country))
            return cell
        case .empty:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.cellReuseIdentifier, for: indexPath) as! CollectionViewCell
            cell.configureWith(kind: .information("Empty", "Empty", "Empty"))
            return cell
        case .error(let Error):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.cellReuseIdentifier, for: indexPath) as! CollectionViewCell
            cell.configureWith(kind: .information("Error", "Error", "Error"))
            return cell
        case .loading(let fromRefreshControl):
            if fromRefreshControl {
                return UICollectionViewCell()
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RefreshViewCell.cellReuseIdentifier, for: indexPath) as! RefreshViewCell
            cell.startAnimating()
            return cell
            
            
            
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width: CGFloat? = 400
        return CGSize(width: width!, height: 100)
    }

    
}

