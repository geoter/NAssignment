//
//  GameTableCell.swift
//  Novibet
//
//  Created by George Termentzoglou on 23/2/20.
//  Copyright © 2020 George Termentzoglou. All rights reserved.
//

import UIKit

class GameTableCell: UITableViewCell {
    @IBOutlet weak var competitor1Label: UILabel!
    @IBOutlet weak var competitor2Label: UILabel!
    @IBOutlet weak var elapsedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        NotificationCenter.default.addObserver(self, selector: #selector(secondElapsed), name:Notification.Name("TikTok"), object: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setTimeLabelText(newText:String){
        DispatchQueue.main.async {
            self.elapsedLabel.text = newText
        }
    }
    
    func configure(gameEvent:Event){
        self.competitor1Label.text = gameEvent.additionalCaptions?.competitor1
        self.competitor2Label.text = gameEvent.additionalCaptions?.competitor2
        
        if let shortTime = gameEvent.liveData?.elapsed?.components(separatedBy:".").first{
           
            let pattern = "(([0-1][0-9])|([2][0-3])):([0-5][0-9]):([0-5][0-9])" //HH:MM:SS
            let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
           
            if predicate.evaluate(with:shortTime) {
               let hours = shortTime.components(separatedBy:":")[0]
               let hoursInt = Int(hours) ?? 0
               let minutes = shortTime.components(separatedBy:":")[1]
               let minutesInt = Int(minutes) ?? 0
               let totalMinutes = minutesInt+hoursInt*60
               let seconds = shortTime.components(separatedBy:":")[2]
               
               let minutesFinalString = (totalMinutes < 10) ? "0\(totalMinutes)":"\(totalMinutes)"

               setTimeLabelText(newText: "\(minutesFinalString):"+seconds)
            }
            else {
                //print("Bad time format: \(shortTime)")
                setTimeLabelText(newText: "-")
            }
            
        }
        else{
            //print("Bad time format: \(gameEvent.liveData.elapsed)")
            setTimeLabelText(newText: "-")
        }
    }
    
    @objc func secondElapsed(){
        if self.elapsedLabel.text == "-"{
            return
        }
        
        let timeString = self.elapsedLabel.text
        if let minutes = timeString?.components(separatedBy:":")[0], let seconds = timeString?.components(separatedBy:":")[1]{
            var minutesInt = Int(minutes) ?? 0
            var secondsInt = Int(seconds) ?? 0
            if secondsInt+1 == 60{
                minutesInt += 1
                secondsInt = 0
            }
            else{
                secondsInt += 1
            }
            let minutesFinalString = (minutesInt < 10) ? "0\(minutesInt)":"\(minutesInt)"
            let secondsFinalString = (secondsInt < 10) ? "0\(secondsInt)":"\(secondsInt)"
            setTimeLabelText(newText:"\(minutesFinalString):\(secondsFinalString)" )
        }
    }
    
    //FIXME: Locally updated time is not stored somewhere. When cell is reused it gets lost
}
