//
//  ViewController.swift
//  motus-ios
//
//  Created by Frederic Dabadie on 09/05/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var verticalStackView: UIStackView!
    @IBOutlet weak var inputWord: UITextField!
    
    
    var data = ["BANANA", "saturn", "satura", "BANATR"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Game.verifyWord(inputWord: "melpied")
        
        verticalStackView.alignment = .center

        
        data.forEach {
            addRows(mot: $0)
        }
       
    }

    @IBAction func pushBtn(_ sender: Any) {
        addRows(mot: "NOUVEA")
    }
    
    
    func addRows(mot:String) {
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        print("mot :"+mot)
        var ctn = 0
        mot.forEach {
            print("lettre :"+String($0))
            let lbl = UILabel()
            lbl.text = String($0)
            lbl.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(lbl)
            lbl.textAlignment = .center
            NSLayoutConstraint.activate([
                lbl.widthAnchor.constraint(equalToConstant: 50),
                lbl.heightAnchor.constraint(equalToConstant: 50)
            ])
            
            
            if((ctn % 2) == 0) {
                lbl.backgroundColor = UIColor.gray
            } else {
                lbl.backgroundColor = UIColor.white
            }
            horizontalStackView.addArrangedSubview(lbl)
            ctn+=1
        }
        verticalStackView.addArrangedSubview(horizontalStackView)
    }
}


