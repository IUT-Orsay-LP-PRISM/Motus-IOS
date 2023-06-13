//
//  ViewController.swift
//  motus-ios
//
//  Created by Frederic Dabadie on 09/05/2023.
//

import UIKit
import Foundation
import CoreData


class ViewController: UIViewController, UITextFieldDelegate {


    @IBOutlet weak var verticalStackView: UIStackView!
    @IBOutlet weak var labelError: UILabel!
    @IBOutlet weak var inputWord: UITextField!
    @IBOutlet weak var pushBtn: UIButton!
    
    var data : [String] = []
    
    
    // Variables liées au CoreData
    var currentMatch : Match = Match()
    var currentMatchSet : MatchSet = MatchSet()
    var canInitMatchSet : Bool = true
    var matchSetBeggingTime = Date()
    var currentMatchSetsInMatch = 0
    var currentMatchSetNumber = 0
    var currentMatchSetScoreArray: [Int16] = []
    let maxNumberTriesInMatchSet = 7
    
    
    

    @IBAction func replay(_ sender: Any) {
        Game.initialiseMatch()
        pushBtn.isEnabled = true
        inputWord.isEnabled = true
        labelError.text! = ""
        inputWord.text! = ""
        viewDidLoad()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        
//        var arrayMatch = fetchAllMatches()
//        self.currentMatch = arrayMatch![arrayMatch!.count - 1]
//        
//        var arrayMatchSets = fetchMatchSets(match: self.currentMatch)
//        self.currentMatchSet = arrayMatchSets![arrayMatchSets!.count - 1]
//        
        verticalStackView.alignment = .center
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
                labelError.text! = "Vous avez perdu\n"+Game.getChosenWord()
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
    
    
    
//
//        // ------------------------------------------------------------------------------------------------
//        // ------------------------------------------------------------------------------------------------
//        // Fonction qui initialise un nouveau Match et l'affecte dans une variable de classe (self.currentMatch)
//        // Retourne Match s'il est crée, nil sinon
//        func initMatch(currentMatchSetsInMatch: Int) -> Match? {
//            // Affectation des valeurs d'un nouveau Match dans les variables de classe pertinantes
//            self.currentMatchSetsInMatch = currentMatchSetsInMatch
//            self.currentMatchSetNumber = 0
//
//            // Manips nécessaires pour Core Data
//            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//                return nil
//            }
//
//            let managedContext = appDelegate.persistentContainer.viewContext
//
//            guard let entity = NSEntityDescription.entity(forEntityName: "Match", in: managedContext) else {
//                return nil
//            }
//
//            // Déclaration du nouveau Match
//            let match = NSManagedObject(entity: entity, insertInto: managedContext) as? Match
//
//            // Initialisation des attributs du nouveau Match
//            match?.score = 0
//            match?.victory = false
//
//            // Sauvegarde du managedContext et affectation du nouveauMatchSet dans une variable de classe
//            do {
//                try managedContext.save()
//                self.currentMatch = match!
//                return match
//            } catch let error as NSError {
//                print("Erreur dans la sauvegarde du managedContext : fonction initMatch(currentMatchSetsInMatch: Int): \(error), \(error.userInfo)")
//                return nil
//            }
//        }
//
//
//
//        // ------------------------------------------------------------------------------------------------
//        // ------------------------------------------------------------------------------------------------
//        // Fonction qui initialise un MatchSet si c'est possible par rapport au Match current et l'affecte
//        // dans une variable de classe (self.currecurrentMatchSetntMatch)
//        // Retourne un MatchSet si c'est possible ou nil sinon
//        func initMatchSet() -> MatchSet? {
//            // Si le match actuel n'accepte plus de matchSets => retourne nill
//            if self.currentMatchSetNumber + 1 > self.currentMatchSetsInMatch {
//                self.canInitMatchSet = false
//                return nil
//            }
//
//            // Si le match actuel accepte des nouveaux matchSets => currentMatchSetNumber+1 ET création du
//            // nouveau matchSet
//            self.currentMatchSetNumber += 1
//
//            // Manips nécessaires pour Core Data
//            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//                return nil
//            }
//
//            let managedContext = appDelegate.persistentContainer.viewContext
//
//            guard let entity = NSEntityDescription.entity(forEntityName: "MatchSet", in: managedContext) else {
//                return nil
//            }
//
//            // Déclaration du nouveau MatchSet
//            let matchSet = NSManagedObject(entity: entity, insertInto: managedContext) as? MatchSet
//
//            // Initialisation des attributs du nouveau MatchSet
//            matchSet?.beginTime = Date()
//            matchSet?.numberTries = 1
//
//            // Sauvegarde du managedContext et affectation du nouveauMatchSet dans une variable de classe
//            do {
//                try managedContext.save()
//                self.currentMatchSet = matchSet!
//                return matchSet
//            } catch let error as NSError {
//                print("Erreur dans la sauvegarde du managedContext : initMatchSet(): \(error), \(error.userInfo)")
//                return nil
//            }
//        }
//
//
//
//        // ------------------------------------------------------------------------------------------------
//        // ------------------------------------------------------------------------------------------------
//        // Fonction qui calcule le score d'un MatchSet
//        // Retourne un Int
//        func calculateScore(difficulty: Int, nbTries: Int, boolVictory: Bool) -> Int16 {
//            var score: Int16 = 0
//
//            if boolVictory {
//                score = Int16(difficulty * (self.maxNumberTriesInMatchSet - nbTries))
//            }
//
//            return score
//        }
//
//
//
//        // ------------------------------------------------------------------------------------------------
//        // ------------------------------------------------------------------------------------------------
//        // Fonction qui doit être executé à la fin de chaque MatchSet.
//        // Crée un nouveau MatchSet, initialise tous ses attributs, l'ajoute à l'instance de la classe
//        // Match qui est attribut de classe (appellé currentMatch) et renseigne si c'est possible d'ajouter
//        // un nouveau MatchSet dans le currentMatch.
//        // Retourne true si le MatchSet est correctement sauvegardé et false sinon
//
//        func finishMatchSet(difficulty: Int, nbTries: Int, boolVictory: Bool) -> Bool {
//            // On renseigne dans l'attribut de classe currentMatchSetNumber, le numéro de MatchSet qu'on
//            // est en train de sauvegarder
//            self.currentMatchSetNumber += 1
//
//            // Manips nécessaires pour Core Data
//            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//                return false
//            }
//
//            let managedContext = appDelegate.persistentContainer.viewContext
//
//            guard let matchSetEntity = NSEntityDescription.entity(forEntityName: "MatchSet", in: managedContext) else {
//                return false
//            }
//
//            // Création d'un nouveau MatchSet et initialisation de tous ses attributs
//            let matchSet = MatchSet(entity: matchSetEntity, insertInto: managedContext)
//
//            matchSet.beginTime = self.matchSetBeggingTime
//            matchSet.numberTries = Int16(nbTries)
//            matchSet.endTime = Date()
//            self.currentMatch.score = Int16(calculateScore(difficulty: difficulty, nbTries: nbTries, boolVictory: boolVictory))
//
//            // Ajout du nouveau matchSet au currentMatch
//            do {
//                try matchSet.belongsTo = self.currentMatch
//
//                // try matchSet.belongsTo(self.currentMatch)
//            } catch {
//                print("Erreur dans l'ajout du MatchSet dans Match : matchSet.belongsTo(self.currentMatch)")
//                return false
//            }
//
//            // Sauvegarde du managedContext
//            do {
//                try managedContext.save()
//
//                // On ajoute le score du MatchSet finit à l'attribut de classe currentMatchSetScoreArray (Array)
//                self.currentMatchSetScoreArray.append(matchSet.score)
//
//                // On renseigne si on peut initier un nouveau MatchSet dans le current Match à travers de
//                // l'attribut de classe self.canInitMatchSet
//                if self.currentMatchSetNumber + 1 > self.currentMatchSetsInMatch {
//                    self.canInitMatchSet = false
//                }
//
//                return true
//            } catch let error as NSError {
//                print("Erreur dans la sauvegarde du managedContext : fonction finishMatchSet(difficulty: Int, nbTries: Int, boolVictory: Bool): \(error), \(error.userInfo)")
//                return false
//            }
//        }
//
//
//
//        // ------------------------------------------------------------------------------------------------
//        // ------------------------------------------------------------------------------------------------
//        // Fonction qui finit un Match et le sauvegarde avec CoreData
//        // Retourne true s'il est sauvegardé, false sinon
//        func finishMatch(difficulty: Int) -> Bool {
//
//            // Si tous les MatchSet dans le Match n'ont pas étés joués => pas possible
//            // de finir le Match
//            if self.currentMatchSetNumber <= self.currentMatchSetsInMatch {
//                return false
//            }
//
//            // Calcul du score du Match : utilisation de l'array contenant tous les scores
//            // des MatchSets
//            var matchScore: Int16 = 0
//            var nbVictories: Int16 = 0
//
//            for i in 0 ..< self.currentMatchSetScoreArray.count {
//                matchScore += self.currentMatchSetScoreArray[i]
//                nbVictories = self.currentMatchSetScoreArray[i] > 0 ? nbVictories + 1 : nbVictories
//            }
//
//            // Manips nécessaires pour Core Data
//            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//                return false
//            }
//
//            let managedContext = appDelegate.persistentContainer.viewContext
//
//            // Affectation des bons valeurs dans les attributs du Match à sauvegarer
//            self.currentMatch.victory = false
//            self.currentMatch.score = matchScore
//
//            if nbVictories >= self.currentMatchSetsInMatch / 2 {
//                self.currentMatch.victory = true
//            }
//
//            // Sauvegarde du managedContext
//            do {
//                try managedContext.save()
//
//                // On renseigne si on peut initier un nouveau MatchSet dans le current Match à travers de
//                // l'attribut de classe self.canInitMatchSet
//                self.canInitMatchSet = true
//
//                return true
//            } catch let error as NSError {
//                print("Error al guardar el managedContext: finishMatch(difficulty: Int): \(error), \(error.userInfo)")
//                return false
//            }
//        }
//
//
//
//        // ------------------------------------------------------------------------------------------------
//        // ------------------------------------------------------------------------------------------------
//        // Fonction qui recupère toutes les instances de la classe Match sauvegardés dans CoreData
//        // Retourne un array de Match si succès, nil si échec
//        func fetchAllMatches() -> [Match]? {
//            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//                return nil
//            }
//
//            let managedContext = appDelegate.persistentContainer.viewContext
//
//            let fetchRequest: NSFetchRequest<Match> = Match.fetchRequest()
//
//            do {
//                let results = try managedContext.fetch(fetchRequest)
//                return results
//            } catch {
//                print("Erreur dans la récuperation des instances de la classe Match => fonction fetchAllMatches() : \(error)")
//                return nil
//            }
//        }
//
//
//
//        // ------------------------------------------------------------------------------------------------
//        // ------------------------------------------------------------------------------------------------
//        // Fonction qui recupère toutes les instances de la classe MatchSet sauvegardés dans CoreData,
//        // appartenant à un Match passé un paramètre
//        // Retourne un array de MatchSets si succès, nil si échec
//        func fetchMatchSets(match: Match?) -> [MatchSet]? {
//            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//                return nil
//            }
//
//            let managedContext = appDelegate.persistentContainer.viewContext
//
//            let fetchRequest: NSFetchRequest<MatchSet> = MatchSet.fetchRequest()
//            fetchRequest.predicate = NSPredicate(format: "belongsTo == %@", match!)
//
//            do {
//                let results = try managedContext.fetch(fetchRequest)
//                return results
//            } catch {
//                print("Erreur dans la récuperation des instances de la classe MatchSet depuis un Match => fonction fetchMatchSets() : \(error)")
//                return nil
//            }
//        }
    
    
    
    
    
    
}
