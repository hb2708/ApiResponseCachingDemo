//
//  PinCollectionViewController.swift
//  HBLoadAnyExample
//
//  Created by Harshal Bhavsar on 18/03/18.
//  Copyright © 2018 Harshal Bhavsar. All rights reserved.
//

import UIKit

class PinCollectionViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var refreshControl:UIRefreshControl!
    var pinCellSize:CGFloat {
        get {
            if UIDevice.current.userInterfaceIdiom == .phone {
                return (UIScreen.main.bounds.width - 30) / 2
            } else {
                return  (UIScreen.main.bounds.width - 30) / 4
            }
        }
    }
    
    
    var visibleDataSource = [PintrestRoot]()
    var masterDataSource = [PintrestRoot]()
    let batchSize = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefreshControl()
        getDataFromServer()
    }
    
    func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.blue
        refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        collectionView?.addSubview(refreshControl)
    }
    
    @objc func reloadData() {
        getDataFromServer()
    }
    
    @IBAction func clearCacheTouched(_ sender: Any) {
        HBCacher.clearCachedObjects()
    }
    
    func startLoader() {
        loadingIndicator.startAnimating()
        loadingIndicator.isHidden = false
    }
    
    func stopLoader() {
        loadingIndicator.stopAnimating()
        loadingIndicator.isHidden = true
    }
}

// MARK: - NetworkCalls
extension PinCollectionViewController {
    func getDataFromServer() {
        guard let url = URL(string: apiURLString) else {
            return
        }
        startLoader()
        HBRequestManager.performRequestOn(url) { (data, error) in
            self.stopLoader()
            guard error == nil else {
                print(error?.localizedDescription ?? "Empty Error Description")
                return
            }
            
            if let data = data {
                do {
                    let pinterestData = try JSONDecoder().decode([PintrestRoot].self, from: data)
                    self.visibleDataSource.removeAll()
                    self.masterDataSource.removeAll()
                    self.masterDataSource.append(contentsOf: pinterestData)
                    let endIndex = self.batchSize < self.masterDataSource.count ? self.batchSize : self.masterDataSource.count
                    self.visibleDataSource += self.masterDataSource[0..<endIndex]
                    self.refreshControl.endRefreshing()
                    self.collectionView?.reloadData()
                } catch let jsonErr {
                    print("Error serializing json:", jsonErr)
                }
            }
        }
    }
}

// MARK: - CollectionView Methods
extension PinCollectionViewController: UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return visibleDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pinCell", for: indexPath) as! PinCollectionViewCell
        let object = visibleDataSource[indexPath.row]
        cell.setImage(object.urls?.thumb) { (image) in
            
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (visibleDataSource.count - 1) && visibleDataSource.count < masterDataSource.count{
            fetchNextBatch()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: pinCellSize, height: pinCellSize)
    }
    
    func fetchNextBatch() {
        let remainingDataCount = masterDataSource.count - visibleDataSource.count
        let numberOfRecordsToLoad = remainingDataCount < batchSize ? remainingDataCount : batchSize
        let nextIndex = visibleDataSource.count + numberOfRecordsToLoad
        visibleDataSource += masterDataSource[visibleDataSource.count..<nextIndex]
        collectionView?.reloadData()
    }
}
