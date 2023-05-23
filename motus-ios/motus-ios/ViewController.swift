//
//  ViewController.swift
//  motus-ios
//
//  Created by Frederic Dabadie on 09/05/2023.
//

import UIKit



class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var verticalStackView: UIStackView!
    
    @IBOutlet weak var inputWord: UITextField!
    
    var data : [String] = []
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        verticalStackView.alignment = .center
        
        Game.initialiseMatch()
        inputWord.maxLength = Game.getChosenWord().count


        // Tableau de mots vide pas defaut
        var defaultWord = String(Game.getChosenWord().first!)
        let lenWord = Game.getChosenWord().count
        for _ in 1..<lenWord  {
            defaultWord = String(defaultWord) + "."
        }

        var defaultWords : [String] = []
        for _ in 0..<7  {
            defaultWords.append(defaultWord)
        }
        Game.setWords(newWords: defaultWords)
        createTable(words: Game.getWords())
        
    }
    
   
    @IBAction func pushBtn(_ sender: Any) {
        let lapCounter = Game.getLapCounter()
        
        if(lapCounter <= 6) {
        let word = inputWord.text!.uppercased()
            
        // Debug test
        let testResult: String = Game.checkInput(inputWord: word) ? "TRUE" : "FALSE"
        Game.appendValueInSavedArrayCheckValue(arrayCheckedValues: Game.checkValuesArray)
        
        print("testResult : " + testResult)
        print("checkValuesArray : ")
        print(Game.checkValuesArray)
            
        var Gamewords = Game.getWords()
        Gamewords[lapCounter] = word
        
        Game.setWords(newWords: Gamewords)
        createTable(words: Game.getWords())
        Game.incrementLapCounter()
        } else {
            // end of game
        }
    }
    

    
    func createTable(words:[String]) {
        verticalStackView.subviews.forEach{(view) in view.removeFromSuperview()}
        for i in 0..<words.count  {
            addRows(mot:words[i])
        }
    }
    

    func addRows(mot:String) {
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal

        
        //Game.SavecheckValuesGame 
        
            
        var ctn = 0
        mot.forEach {
            // print("lettre :"+String($0))
            let lbl = UILabel()
            lbl.text = String($0)
            lbl.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(lbl)
            lbl.textAlignment = .center
            NSLayoutConstraint.activate([
                lbl.widthAnchor.constraint(equalToConstant: 50),
                lbl.heightAnchor.constraint(equalToConstant: 50)
            ])
            
            
            
            
            if(Game.checkValuesArray[ctn] == 2) {
                lbl.backgroundColor = UIColor.red
            } else if(Game.checkValuesArray[ctn] == 1) {
                lbl.backgroundColor = UIColor.orange
            } else {
                lbl.backgroundColor = UIColor.white
            }

  
            horizontalStackView.addArrangedSubview(lbl)
            ctn+=1
        }
        verticalStackView.addArrangedSubview(horizontalStackView)

    }
}
