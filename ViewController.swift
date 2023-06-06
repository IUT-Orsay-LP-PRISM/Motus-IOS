//
//  ViewController.swift
//  EssaiBDD
//
//  Created by Christopher Dent on 09/05/2023.
//

import UIKit
import Foundation
import CoreData
import Game

class ViewController: UIViewController {
    
    // Variables liées au dictionnaire
    var dictionary : [String] = []
    var reducedDictionary : [String] = []
    var matchWord : String = "unsettedWord"

    // Variables liées au CoreData
    var currentMatchSet : NSManagedObject = NSManagedObject()
    var canInitMatchSet : Bool = True
    var matchSetBeggingTime = Date()
    var currentMatchSetsInMatch = 0
    var currentMatchSetNumber = 0
    var currentMatchSetArray = [MatchSet]()
    let maxNumberTriesInMatchSet = 7
    

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if(Game.currentMatchSetArray.count() > self.maxNumberTriesInMatchSet){
            initMatch(currentMatchSetsInMatch : self.currentMatchSetNumber)
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        // Affectation de l'ensemble des mots dans le dictionnaire globale des variables
        initDictionnaryArray();
        
        // Sélection du dictionnaire réduit en fonction des valeurs choisies par l'utilisateur
        reducedDictionaryByNumberOfLetters(minimumNumberOfLetters : 5,maximumNumberOfLetters : 8)
        
        // Sélection d'un mot au hazard pioché du dictionnaire de mots réduit
        self.matchWord = self.reducedDictionary.randomElement()!
        
        
        
        // ------------------------------------------------------------
        // Debug log prints
        
        print("Reduced dictionary :\n")
        print(self.reducedDictionary)
        
        print("Chosen match word :\n")
        print(self.matchWord)
        
        print("Timestamp :\n")
        print(String(nsdateToInt(nsdate: Date())))
        
        print("Timestamp :\n")
        // let dateFormatter = DateFormatter()
        // dateFormatter.dateFormat = "dd/MM/YY HH:mm:ss"
        print(dateToNSDate(outputFormat: "dateTime", date: Date()))
    }
    
    
    
    
    
    
    // ---------------------------------------------------------------------------
    // ---------------------------------------------------------------------------
    // ---------------------------------------------------------------------------
    // Charge toutes les mots qui sont dans le fichier ods6 contenant toutes les
    // mots disponibles dans le jeu et les affecte à l'attribut "dictionary" de la classe
    func initDictionnaryArray(){
        var contents = ""
        if let filepath = Bundle.main.path(forResource: "ods6", ofType: "txt") {
            do {
                contents = try String(contentsOfFile: filepath)
            } catch {
                print("contents could not be loaded")
            }
        } else {
            print("filepath marche pas")
        }
    
        // Writes the dictionary = each word of the variable contents is an element of the variable dictionary
        self.dictionary = contents.components(separatedBy: "\n")
    }
    
    
    
    // ---------------------------------------------------------------------------
    // ---------------------------------------------------------------------------
    // ---------------------------------------------------------------------------
    // Affecte toutes les mots qui contiennent le nombre de caractères minimal et maximale passé en paramètre à l'attribut "reducedDictionary" de la classe
    func reducedDictionaryByNumberOfLetters(minimumNumberOfLetters: Int, maximumNumberOfLetters: Int) {
        self.reducedDictionary = []
        
        for word in self.dictionary {
            if (word.count >= minimumNumberOfLetters && word.count <= maximumNumberOfLetters) {
                self.reducedDictionary.append(word)
            }
        }
    }
    
    
    // ---------------------------------------------------------------------------
    // ---------------------------------------------------------------------------
    // ---------------------------------------------------------------------------
    // Prend en paramètre une NSDate et retourne son équivalent en entier
    func nsdateToInt(nsdate: Date) -> Int {
        // convert Date to TimeInterval (typealias for Double)
        let timeInterval = nsdate.timeIntervalSince1970

        // convert to Integer
        return Int(timeInterval)
    }
    
    
    
    // ---------------------------------------------------------------------------
    // ---------------------------------------------------------------------------
    // ---------------------------------------------------------------------------
    // Prends en paramètre un entier et retourne son équivalent en NSDate
    func intToNSDate(number: Int) -> Date {
        // convert Int to TimeInterval (typealias for Double)
        let timeInterval = TimeInterval(number)

        // create NSDate from Double (NSTimeInterval)
        return Date(timeIntervalSince1970: timeInterval)
    }
    
    
    
    // ---------------------------------------------------------------------------
    // ---------------------------------------------------------------------------
    // ---------------------------------------------------------------------------
    // Prends en paramètre un entier et retourne son équivalent en NSDate
    func dateToNSDate(outputFormat: String, date: Date) -> String {
        let dateFormatter = DateFormatter()
        
        switch outputFormat {
        case "date":
            dateFormatter.dateFormat = "dd/MM/YY"
            break
            
        case "time":
            dateFormatter.dateFormat = "HH:mm:ss"
            break
            
        case "dateTime":
            dateFormatter.dateFormat = "dd/MM/YY HH:mm:ss"
            break
            
        default:
            return "Convertion Error : NSDate to string"
        }
        
        
        return dateFormatter.string(from: date as Date)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // -----------------------------------------------------------------------------------------------
    // -----------------------------------------------------------------------------------------------
    // -----------------------------------------------------------------------------------------------
    // -----------------------------------------------------------------------------------------------
    // -----------------------------------------------------------------------------------------------
    // -----------------------------------------------------------------------------------------------
    // -----------------------------------------------------------------------------------------------
    // -----------------------------------------------------------------------------------------------
    // -----------------------------------------------------------------------------------------------
    // -----------------------------------------------------------------------------------------------
    // Fonctions CoreData
    
    
    
    // -----------------------------------------------------------------------------------------------
    // initMatch() : crée un nouveau Match (affecté à la variable statique de la classe currentMatch)
    // et le premier MatchSet du Match (affecté à la variable statique de la classe currentMatchSet)
    // Retourne Booléan = true si crée, faux sinon
    func initMatch(currentMatchSetsInMatch : Int){
        
        self.currentMatchSetsInMatch = currentMatchSetsInMatch
        self.currentMatchSetNumber = 0
        
         //1
         guard let appDelegate =
         //2
             UIApplication.shared.delegate as? AppDelegate else {
             return
            }
        let managedContext =
         appDelegate.persistentContainer.viewContext
        
        let match = NSManagedObject.init(entity: NSEntityDescription.entity(
        forEntityName: "Match", in:managedContext)!, insertInto: managedContext)
        
        match.setValue(0, forKeyPath : "score")
        match.setValue(false, forKeyPath : "victory")
        
        Game.currentMatch = match
    }
    
    
    // -----------------------------------------------------------------------------------------------
    // initMatchSet() : crée un nouveau MatchSet et il est affecté à la variable
    // statique de la classe currentMatchSet
    // Retourne Booléan = true si crée, faux sinon
    func initMatchSet(){
        if(self.currentMatchSetNumber + 1 > self.currentMatchSetsInMatch){
            self.canInitMatchSet = false
            return
        }
        
        self.currentMatchSetNumber += 1
        
         //1
         guard let appDelegate =
         //2
             UIApplication.shared.delegate as? AppDelegate else {
             return
            }
        let managedContext =
         appDelegate.persistentContainer.viewContext
        
        let matchSet = NSManagedObject.init(entity: NSEntityDescription.entity(
        forEntityName: "MatchSet", in:managedContext)!, insertInto: managedContext)
        
        matchSet.setValue(Date(), forKeyPath : "beginTime")
        matchSet.setValue(1, forKeyPath : "numberTries")
        matchSet.setValue(false, forKeyPath : "victory")
        
        self.currentMatchSet = matchSet
    }
    
    
    // -----------------------------------------------------------------------------------------------
    // initMatchSet() : crée un nouveau MatchSet et il est affecté à la variable
    // statique de la classe currentMatchSet
    // Retourne Booléan = true si crée, faux sinon
    func calculateScore(difficulty : Int, nbTries : Int, boolVictory : Bool) -> Int{
        var score : Int = 0
        if (boolVictory){
            let score = difficulty * (self.maxNumberTriesInMatchSet - nbTries)
        }
        return score
    }
    
    
    // -----------------------------------------------------------------------------------------------
    // initMatchSet() : crée un nouveau MatchSet et il est affecté à la variable
    // statique de la classe currentMatchSet
    // Retourne Booléan = true si crée, faux sinon
    func finishMatchSet(difficulty : Int, nbTries : Int, boolVictory : Bool){
        
            if(!self.canInitMatchSet){
                return
            }
            
            self.currentMatchSetNumber += 1
            
             //1
             guard let appDelegate =
             //2
                 UIApplication.shared.delegate as? AppDelegate else {
                 return
                }
            let managedContext =
             appDelegate.persistentContainer.viewContext
            
            let matchSet = NSManagedObject.init(entity: NSEntityDescription.entity(
            forEntityName: "MatchSet", in:managedContext)!, insertInto: managedContext)
            
        matchSet.setValue(self.matchSetBeggingTime, forKeyPath : "beginTime")
        matchSet.setValue(nbTries, forKeyPath : "numberTries")
        matchSet.setValue(boolVictory, forKeyPath : "victory")
        matchSet.setValue(Date(), forKeyPath : "endTime")
        matchSet.setValue(calculateScore(difficulty : difficulty, nbTries : nbTries, boolVictory : boolVictory), forKeyPath : "finalScore")
        
        Game.currentMatchSetArray.append(matchSet)
        matchSet.belongs(Game.currentMatch)
        
        if(self.currentMatchSetNumber + 1 > self.currentMatchSetsInMatch){
            self.canInitMatchSet = false
            return
        }
    }
    
    
    // -----------------------------------------------------------------------------------------------
    // initMatchSet() : crée un nouveau MatchSet et il est affecté à la variable
    // statique de la classe currentMatchSet
    // Retourne Booléan = true si crée, faux sinon
    func finishMatch(difficulty : Int) -> Bool{
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
            if(DBManagement.currentMatchSetNumber <= DBManagement.currentMatchSetsInMatch){
                return false
            }
            
            var matchScore : Int16 = 0
            let matchMaxScore : Int16 = Int16(difficulty * (DBManagement.maxNumberTriesInMatchSet - 1) * DBManagement.currentMatchSetsInMatch)
            for i in 0 ..< DBManagement.currentMatchSetArray.count{
                matchScore += DBManagement.currentMatchSetArray[i].finalScore
            }
            
            var finishedMatch = Match()
            
            finishedMatch.victory = false
            finishedMatch.score = matchScore
            
            if(matchScore >= matchMaxScore/2){
                finishedMatch.victory = true
            }
            return true
        
        
        
        
    }
    

    
    
    // -----------------------------------------------------------------------------------------------
    // initMatchSet() : crée un nouveau MatchSet et il est affecté à la variable
    // statique de la classe currentMatchSet
    // Retourne Booléan = true si crée, faux sinon
    func saveMatchSet(){
        
        
        
        
        
        
        
        
    }


// -----------------------------------------------------------------------------------------------
// initMatchSet() : crée un nouveau MatchSet et il est affecté à la variable
// statique de la classe currentMatchSet
// Retourne Booléan = true si crée, faux sinon
func saveMatch(){
    
    
    
    
    
    
    
    
}

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
