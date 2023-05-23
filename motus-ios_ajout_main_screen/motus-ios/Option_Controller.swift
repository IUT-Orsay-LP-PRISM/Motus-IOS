//
//  Option_Controller.swift
//  motus-ios
//
//  Created by Christopher Dent on 23/05/2023.
//

import UIKit

class Option_Controller: UIViewController {

    @IBOutlet weak var outlet_OptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        outlet_OptionLabel.font = outlet_OptionLabel.font.withSize(50)

        // Do any additional setup after loading the view.
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
