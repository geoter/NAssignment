//
//  GamesTableVC.swift
//  Novibet
//
//  Created by George Termentzoglou on 22/2/20.
//  Copyright © 2020 George Termentzoglou. All rights reserved.
//

import UIKit

class GamesTableVC: UITableViewController {

    let gamesManager = GamesManager()
    var gamesEvents:[Event] = []
    var tiktokTimer:Timer? //per second
    var gamesUpdateTimer:Timer? //per interval
        
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.Games.getGames(endPoint: .games){[weak self] (response, error) in
            guard let strongSelf = self else{return}
            
            if let gamesData = response as? GamesJSON{
                strongSelf.gamesEvents = strongSelf.gamesManager.getGamesEvents(for: gamesData)
                strongSelf.tableView.reloadData()
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
        
        gamesUpdateTimer = Timer.scheduledTimer(timeInterval: self.gamesManager.updateInterval, target: self, selector: #selector(updateGamesDataModels), userInfo: nil, repeats: true)
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
        NotificationCenter.default.post(name:Notification.Name("updateGames") , object: nil)
        
        
    }
    
    // MARK: - Table view

    enum SectionKind: Int, CaseIterable {
        case Header,Games
        
        var headerTitle: String {
            switch self {
                case .Header:  return ""
                case .Games:   return "Ποδόσφαιρο"
           }
        }
        
        var cellIdentifier: String {
            switch self {
            case .Header:
                return "HeaderCell"
            case .Games:
                return "GameCell"
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 1
        case 1:
            return gamesEvents.count
        default:
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellIdentifier = SectionKind.Games.cellIdentifier
        var sectionKind = SectionKind.Games
        
        if let sectionType = SectionKind(rawValue: indexPath.section){
            cellIdentifier = sectionType.cellIdentifier
            sectionKind = sectionType
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier:cellIdentifier, for: indexPath)
        
        if sectionKind == .Games{
            let eventCell = cell as! GameTableCell
            let gameEvent:Event = gamesEvents[indexPath.row]
            eventCell.configure(gameEvent: gameEvent)
        }

        return cell
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
