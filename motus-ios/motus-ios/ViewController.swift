//
//  ViewController.swift
//  motus-ios
//
//  Created by Frederic Dabadie on 09/05/2023.
//

import UIKit



class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var verticalStackView: UIStackView!
    
    @IBOutlet weak var labelError: UILabel!
    @IBOutlet weak var inputWord: UITextField!
    @IBOutlet weak var pushBtn: UIButton!
    
    var data : [String] = []
    
    @IBAction func replay(_ sender: Any) {
        Game.initialiseMatch()
        pushBtn.isEnabled = true
        inputWord.isEnabled = true
        labelError.text! = ""
        viewDidLoad()
    }
    
    @IBAction func btnPlay_StartGame(_ sender: Any) {
        Game.initialiseMatch()
    }
    
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
        // Afin d'avoir une homogénéité avec le code logique
        var defaultWords : [String] = []
        for _ in 0..<7  {
            defaultWords.append(defaultWord)
        }
        Game.setWords(newWords: defaultWords)
        
        // Avoir l'affichage
        createTable(words: Game.getWords())
    }
    
   
    @IBAction func pushBtn(_ sender: Any) {
        if(inputWord.text!.count != Game.getChosenWord().count){
            labelError.text! = "Votre mot n'est pas assez grand !"
        }else{
            labelError.text! = ""
            let lapCounter = Game.getLapCounter()
        
            var gameWon: Bool = false
            
            // Si le nombre d'essais est dépassé
            if(lapCounter <= 6) {
                let word = inputWord.text!.uppercased()
                gameWon = Game.checkInput(inputWord: word)
                if(gameWon){
                    labelError.text! = "Vous avez gagné"
                    inputWord.isEnabled = false
                    pushBtn.isEnabled = false
                }

                Game.appendValueInSavedArrayCheckValue(arrayCheckedValues: Game.checkValuesArray)
                    
                var Gamewords = Game.getWords()
                Gamewords[lapCounter] = word
                
                // Met à jour l'affichage
                Game.setWords(newWords: Gamewords)
                createTable(words: Game.getWords())
                Game.incrementLapCounter()
            }
            // Si le nombre d'essais est dépassé et que la partie n'est pas gagnée
            if(lapCounter == 6 && !gameWon){
                labelError.text! = "Vous avez perdu"
                inputWord.isEnabled = false
                pushBtn.isEnabled = false
            }
        }
    }
    

    
    func createTable(words:[String]) {
        verticalStackView.subviews.forEach{(view) in view.removeFromSuperview()}
        for i in 0..<words.count  {
            addRows(mot:words[i], index:i)
        }
        print(Game.SavecheckValuesGame)
    }
    

    func addRows(mot:String, index:Int) {
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
            
            

            if(index >= 0 && Game.SavecheckValuesGame.count > index)
            {
                if(Game.SavecheckValuesGame[index][ctn] == 2) {
                    lbl.backgroundColor = UIColor.red
                } else if(Game.SavecheckValuesGame[index][ctn] == 1) {
                    lbl.backgroundColor = UIColor.orange
                } else {
                    lbl.backgroundColor = UIColor.white
                }
                
            } else {
                lbl.backgroundColor = UIColor.white
            }
  
            horizontalStackView.addArrangedSubview(lbl)
            ctn+=1
        }
        verticalStackView.addArrangedSubview(horizontalStackView)

    }
}
