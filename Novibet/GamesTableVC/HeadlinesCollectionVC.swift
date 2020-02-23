//
//  HeadlinesCollectionVC.swift
//  Novibet
//
//  Created by George Termentzoglou on 23/2/20.
//  Copyright © 2020 George Termentzoglou. All rights reserved.
//

import UIKit

private let reuseIdentifier = "HeaderCell"

class HeadlinesCollectionVC: UICollectionViewController {

    let headlinesManager = NetworkManager.shared.Headlines
    var headlines:[Headline] = []
    var tiktokTimer:Timer? //per second
    var gamesUpdateTimer:Timer? //per interval
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(UINib.init(nibName: "HeadlineCell", bundle: nil), forCellWithReuseIdentifier: "HeaderCell")
        if let flowlayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            flowlayout.estimatedItemSize = CGSize(width: 360,height: 85)
        }
        
        headlinesManager.getHeadlines(endPoint: .headlines){[weak self] (response, error) in
            guard let strongSelf = self else{return}
            
            if let gamesData = response as? HeadlinesJSON{
                strongSelf.headlines = strongSelf.headlinesManager.getHeadlinesEvents(for: gamesData)
                strongSelf.collectionView.reloadData()
            }
            else{
                print(error)
            }
        }
    }
    
   override func viewDidAppear(_ animated: Bool) {
       super.viewDidAppear(animated)
       initializeTimers()
   }
   
   override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       invalidateTimers()
   }
   
   // MARK: - Timers
   
   func initializeTimers(){
       tiktokTimer = Timer(timeInterval: 1.0, target: self, selector: #selector(tiktok), userInfo: nil, repeats: true)
       RunLoop.current.add(tiktokTimer!, forMode: RunLoop.Mode.common)
       
       //gamesUpdateTimer = Timer.scheduledTimer(timeInterval: self.headlinesManager.updateInterval, target: self, selector: #selector(updateGamesDataModels), userInfo: nil, repeats: true)
   }
   
   func invalidateTimers(){
       tiktokTimer?.invalidate()
       tiktokTimer = nil
       
       gamesUpdateTimer?.invalidate()
       gamesUpdateTimer = nil
   }
   
   @objc func tiktok() {
       NotificationCenter.default.post(name:Notification.Name("TikTok") , object: nil)
   }
   
   @objc func updateGamesDataModels() {
       headlinesManager.getHeadlines(endPoint: .updateHeadlines){[weak self] (response, error) in
           guard let strongSelf = self else{return}
           
           if let gamesData = response as? HeadlinesJSON{
               strongSelf.headlines = strongSelf.headlinesManager.getHeadlinesEvents(for: gamesData)
               strongSelf.collectionView.reloadData()
           }
           else{
               print(error)
           }
       }
   }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return headlines.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        if let c = cell as? HeadlineCell{
            c.configure(headlineItem: headlines[indexPath.item])
        }
        // Configure the cell
    
        return cell
    }

}
