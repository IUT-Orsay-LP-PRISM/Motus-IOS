//
//  GameLogic.swift
//  IOS_Project
//
//  Created by Joel Herranz Bustamante on 09/05/2023.
//

import Foundation

class GameLogic{
    static let wordLibrary: [String] = ["fly"]//, "run", "why"]
    static var checkValuesArray: [Int] = []
    static var matchWord: String = ""
    //static var inputWord: String = ""
    static var matchWordArray: [Character] = []
    
    
    // -----------------------------------------------------------------------------------------------
    // -----------------------------------------------------------------------------------------------
    // -----------------------------------------------------------------------------------------------
    // Méthodes
    
    
    // -----------------------------------------------------------------------------------------------
    // initialiseMatch() : initialisation = choix du mot, affectation des arrays matchWorkArray et
    // checkValuesArray
    // Retourne void
    static func initialiseMatch(){
        // Choix du mot de la partie
        GameLogic.matchWord = GameLogic.wordLibrary.randomElement()!
        
        // Mot du match convertie en Array de caractères
        GameLogic.matchWordArray = GameLogic.tablify(word: GameLogic.matchWord)
        
        // Initialisation de l'array de vérification avec la bonne taille
        GameLogic.checkValuesArray = Array(repeating:0, count:GameLogic.matchWordArray.count)
        
        // Debug test
        /*
        print("Mot selectionné : " + GameLogic.matchWord)
        let inputTest: String = "fxd"
        print("Mot input : " + inputTest)
        let testResult: String = GameLogic.checkInput(inputWord: inputTest) ? "TRUE" : "FALSE"
        print("testResult : " + testResult)
        print("checkValuesArray : ")
        print(checkValuesArray)
         */
    }
    
    
    // -----------------------------------------------------------------------------------------------
    // tablify(word : String) : transforme un String passé en paramètre en array de caractéres
    // Retourne tableau de caractères
    static func tablify(word : String) -> [Character]{
        return Array(word.uppercased())
    }
    
    
    // -----------------------------------------------------------------------------------------------
    // checkInput(inputWord: String) : vérifie l'input String de l'utilisateur (passé en paramètre)
    // et saisit l'array contenant le statut de chaque caractère de l'input
    // (2 = bon caractère + bonne position // 1 = bon caractère // 0 = caractère incorrèct)
    // Retourne booléen (TRUE = mot trouvé / FALSE = mot pas trouvée)
    static func checkInput(inputWord: String) -> Bool{
        
        GameLogic.checkValuesArray = Array(repeating: 0, count: GameLogic.matchWordArray.count)
        let inputWordUpperCased = inputWord.uppercased()
        
        // Mot trouvée
        if inputWordUpperCased == matchWord.uppercased(){
            GameLogic.checkValuesArray = Array(repeating: 2, count: GameLogic.matchWordArray.count)
            GameLogic.matchWordArray = []
            return true
        }
        
        // Vérification des caractères dans le bonne position
        let inputWordArray = GameLogic.tablify(word: inputWordUpperCased)
        var workMatchWordArray = GameLogic.matchWordArray
        
        for i in 0..<GameLogic.matchWordArray.count{
            if(inputWordArray[i] == workMatchWordArray[i]){
                workMatchWordArray[i] = " "
                GameLogic.checkValuesArray[i] = 2 // 2 == bonne caractère à la bonne position
            }
        }
        
        // Vérification des caractères PAS dans le bonne position
        for i in 0..<GameLogic.matchWordArray.count{
            for j in 0..<GameLogic.matchWordArray.count{
                if(inputWordArray[i] == workMatchWordArray[j]){
                    workMatchWordArray[j] = " "
                    GameLogic.checkValuesArray[i] = 1 // 1 == bonne caractère PAS à la bonne position
                    break
                }
            }
        }
        return false            
    }
