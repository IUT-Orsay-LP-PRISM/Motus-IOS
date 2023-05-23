//
//  Ecran_Accueil_Controller.swift
//  motus-ios
//
//  Created by Christopher Dent on 23/05/2023.
//

import UIKit

class Ecran_Accueil_Controller: UIViewController {
    

    @IBOutlet weak var outlet_PlayOneGame: UIButton!
    
    @IBOutlet weak var outlet_OtherGameType: UIButton!
    
    @IBOutlet weak var outlet_Options: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor =  UIColorFromHex(rgbValue:0xFCA33D,alpha: 1)
        outlet_PlayOneGame.backgroundColor = UIColorFromHex(rgbValue:0xFFFFFF,alpha: 1)
        outlet_OtherGameType.backgroundColor =     UIColorFromHex(rgbValue:0xFFFFFF,alpha: 1)
        outlet_Options.backgroundColor =     UIColorFromHex(rgbValue:0xFFFFFF,alpha: 1)
        
        // Do any additional setup after loading the view.
    }
    
    // Returns UIColor with hexa as entry paramter
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0

        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    @IBAction func btn_PlayOneGame(_ sender: Any) {
    }
    
    @IBAction func retourDansMainScreen(segue : UIStoryboardSegue) {
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue,sender: Any?){
    if segue.identifier == "MainVueAOneGame" {
        // Definition du controler de destinatation
        let destinationVC = segue.destination as! ViewController
    } else if segue.identifier == "MainVueAOptions" {
        // Definition du controler de destinatation
        let destinationVC = segue.destination as! Option_Controller
    }
    // Transfert de données
    //destinationVC.valeurVue2 = valeurVue1
    }

}
