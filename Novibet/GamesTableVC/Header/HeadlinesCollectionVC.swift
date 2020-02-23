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
    
    // MARK: - Timers
    var carouselTimer:Timer? //per second
    var headlinesUpdateTimer:Timer? //per interval
    
    enum CarouselDirection{
        case toRight
        case toLeft
    }
    var carouselDirection:CarouselDirection = .toRight
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(UINib.init(nibName: "HeadlineCell", bundle: nil), forCellWithReuseIdentifier: "HeaderCell")
        if let flowlayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            flowlayout.estimatedItemSize = CGSize(width: self.collectionView.frame.size.width,height: 85)
        }
        
        headlinesManager.getHeadlines(endPoint: .headlines){[weak self] (response, error) in
            guard let strongSelf = self else{return}
            
            if let gamesData = response as? HeadlinesJSON{
                strongSelf.headlines = strongSelf.headlinesManager.getHeadlinesEvents(for: gamesData)
                strongSelf.collectionView.reloadData()
            }
            else{
                print(error.debugDescription)
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

}


// MARK: - Timers
extension HeadlinesCollectionVC{
      
      func initializeTimers(){
          carouselTimer = Timer(timeInterval: 5.0, target: self, selector: #selector(carouselSpin), userInfo: nil, repeats: true)
          RunLoop.current.add(carouselTimer!, forMode: RunLoop.Mode.common)
          
          headlinesUpdateTimer = Timer.scheduledTimer(timeInterval: self.headlinesManager.updateInterval, target: self, selector: #selector(updateHeadlinesDataModels), userInfo: nil, repeats: true)
      }
      
      func invalidateTimers(){
          carouselTimer?.invalidate()
          carouselTimer = nil
          
          headlinesUpdateTimer?.invalidate()
          headlinesUpdateTimer = nil
      }
      
    
    @objc func carouselSpin(){

        guard headlines.count>1 else{return}
        
        let isScrolling: Bool = collectionView.isDragging || collectionView.isDecelerating
        if isScrolling {return}
        
        //get cell size
        let collectionViewSize = CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)

        let contentOffset = collectionView.contentOffset;
        
        if contentOffset.x <= 0{
            carouselDirection = .toRight
        }
        else if Int(contentOffset.x) >= (headlines.count-1)*Int(collectionViewSize.width){
            carouselDirection = .toLeft
        }
        
        
        var newX:Int = 0
        if carouselDirection == .toLeft{
            newX = Int(contentOffset.x - collectionViewSize.width)
        }
        else{
            newX = Int(contentOffset.x + collectionViewSize.width)
        }
        
        //scroll to next cell
        collectionView.scrollRectToVisible(CGRect(x:CGFloat(newX) , y: contentOffset.y, width: collectionViewSize.width, height: collectionViewSize.height), animated: true);

    }
    
      
      @objc func updateHeadlinesDataModels() {
        //FIXME: updatehealines json parsing fails, I use .headlines for testing
          headlinesManager.getHeadlines(endPoint: .headlines){[weak self] (response, error) in
              guard let strongSelf = self else{return}
              
              if let gamesData = response as? HeadlinesJSON{
                  strongSelf.headlines = strongSelf.headlinesManager.getHeadlinesEvents(for: gamesData)
                 //FIXME: reload and carousel
                  strongSelf.collectionView.reloadData()
              }
              else{
                print(error.debugDescription)
              }
          }
      }
}

// MARK: - UICollectionViewDataSource
extension HeadlinesCollectionVC{
    
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
         c.cellWidthConstraint.constant = self.collectionView.frame.size.width
         c.layoutIfNeeded()
         c.configure(headlineItem: headlines[indexPath.item])
       }
       // Configure the cell
   
       return cell
   }

}
