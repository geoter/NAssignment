//
//  HeadlineCell.swift
//  Novibet
//
//  Created by George Termentzoglou on 23/2/20.
//  Copyright © 2020 George Termentzoglou. All rights reserved.
//

import UIKit

class HeadlineCell: UICollectionViewCell {

    @IBOutlet weak var competitor1Label: UILabel!
    @IBOutlet weak var competitor2Label: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(headlineItem:Headline){
        competitor1Label.text = headlineItem.competitor1Caption
        competitor2Label.text = headlineItem.competitor2Caption
        startTimeLabel.text = headlineItem.startTime
    }
}
