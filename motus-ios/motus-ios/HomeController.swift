//
//  HomeController.swift
//  motus-ios
//
//  Created by Frederic Dabadie on 06/06/2023.
//
import UIKit
class HomeController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func btnStart_Game(_ sender: UIButton) {
        let textLevel = sender.titleLabel!.text!
        
        switch(textLevel) {
        case "Facile":
            Game.level = 1
        case "Moyen":
            Game.level = 2
        case "Difficile":
            Game.level = 3
        case "Hardcore":
            Game.level = 4
        default:
            Game.level = 1
        }
        Game.initialiseMatch()
        
    }
}
