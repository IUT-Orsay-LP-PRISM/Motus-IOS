//
//  ViewController.swift
//  EssaiBDD
//
//  Created by Christopher Dent on 09/05/2023.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    var dictionary : [String] = []
    var reducedDictionary : [String] = []
    var matchWord : String = "unsettedWord"


    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    
    
    
}
