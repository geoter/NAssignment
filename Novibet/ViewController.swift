//
//  ViewController.swift
//  Novibet
//
//  Created by George Termentzoglou on 22/2/20.
//  Copyright © 2020 George Termentzoglou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func signInPressed(_ sender: Any) {
        NetworkManager.shared.Auth.signIn(username: "your_first_name", password: "your_sire_name")
        { (success, error) in
            if success{
                self.performSegue(withIdentifier:"showGames", sender: self)
            }
            else{
                // TODO: fix switch cases for error enum
                alert(title: "Error", message:"Could not sign in. Please try again.").presentInView(controller: self)
            }
        }
    }
}


