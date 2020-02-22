//
//  sharedLogic.swift
//  Novibet
//
//  Created by George Termentzoglou on 22/2/20.
//  Copyright © 2020 George Termentzoglou. All rights reserved.
//

import UIKit

func alert(title:String,message:String) -> UIAlertController {
    let alert =  UIAlertController(title: title, message: message, preferredStyle: .alert)
    let ok = UIAlertAction(title: "OK", style: .default)
    alert.addAction(ok)
    return alert
}

extension UIAlertController{
    func presentInView(controller:UIViewController){
        controller.present(self, animated: true, completion: nil)
    }
}
