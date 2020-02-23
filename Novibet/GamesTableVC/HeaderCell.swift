//
//  HeaderCell.swift
//  Novibet
//
//  Created by George Termentzoglou on 23/2/20.
//  Copyright © 2020 George Termentzoglou. All rights reserved.
//

import UIKit

class HeaderCell: UITableViewCell {

    var collectionVC:UICollectionViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "HeadlinesCollectionVC") as! UICollectionViewController
        self.collectionVC = controller
        self.collectionVC?.view.translatesAutoresizingMaskIntoConstraints = false
        let collectionView = self.collectionVC!.view!
        self.addSubview(collectionView)
        
        collectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
