//
//  Game.swift
//  motus_programmation
//
//  Created by Romain Fromentin on 09/05/2023.
//

import Foundation
class Game {
    public static let wordLibrary: [String] = ["BANANA"] //, "run", "why"]
    public static var chosenWord: String = "";
    public static var matchWordArray: [Character] = []
    public static var checkValuesArray: [Int] = []
    
    public static var words : [String] = []
    public static var lapCounter = 0
    public static var SavecheckValuesGame: [[Int]] = []
    
    
    
    // -----------------------------------------------------------------------------------------------
    // initialiseMatch() : initialisation = choix du mot, affectation des arrays matchWorkArray et
    // checkValuesArray
    // Retourne void
    public static func initialiseMatch(){
        // Choix du mot de la partie
        chosenWord = wordLibrary.randomElement()!
        
        // Mot du match convertie en Array de caractères
        matchWordArray = tablify(word: chosenWord)
        
        // Initialisation de l'array de vérification avec la bonne taille
        checkValuesArray = Array(repeating:0, count:matchWordArray.count)
    }
    
    
    
    // -----------------------------------------------------------------------------------------------
    // checkInput(inputWord: String) : vérifie l'input String de l'utilisateur (passé en paramètre)
    // et saisit l'array contenant le statut de chaque caractère de l'input
    // (2 = bon caractère + bonne position // 1 = bon caractère // 0 = caractère incorrèct)
    // Retourne booléen (TRUE = mot trouvé / FALSE = mot pas trouvée)
    static func checkInput(inputWord: String) -> Bool{
        
        checkValuesArray = Array(repeating: 0, count: matchWordArray.count)
        let inputWordUpperCased = inputWord.uppercased()
        
        // Mot trouvée
        if inputWordUpperCased == chosenWord.uppercased(){
            checkValuesArray = Array(repeating: 2, count: matchWordArray.count)
            matchWordArray = []
            return true
        }
        
        // Vérification des caractères dans le bonne position
        let inputWordArray = tablify(word: inputWordUpperCased)
        var workMatchWordArray = matchWordArray
        
        for i in 0..<matchWordArray.count{
            if(inputWordArray[i] == workMatchWordArray[i]){
                workMatchWordArray[i] = " "
                checkValuesArray[i] = 2 // 2 == bonne caractère à la bonne position
            }
        }
        
        // Vérification des caractères PAS dans le bonne position
        for i in 0..<matchWordArray.count{
            for j in 0..<matchWordArray.count{
                if(checkValuesArray[i] == 0){
                    if(inputWordArray[i] == workMatchWordArray[j]){
                        workMatchWordArray[j] = " "
                        checkValuesArray[i] = 1 // 1 == bonne caractère PAS à la bonne position
                        break
                    }
                }
            }
        }
        return false
    }
    
    

    // Transformer les mots en tableaux, puisque Swift ne veut pas utiliser les String comme des tableaux de charactères
    // Retourne tableau de caractères
    public static func tablify(word: String) -> [Character]{
        var tempWord = word
        var letters : [Character] = []
        for char in word{
            letters.append(char)
            tempWord.remove(at: tempWord.startIndex)
        }
        
        letters = letters.map{
            return Character($0.uppercased())
        };
        return letters
    }
    
    

    public static func getChosenWord() -> String{
        return chosenWord
    }
    
    
    
    public static func getWords() -> [String] {
        return words
    }
    public static func setWords(newWords:[String]) {
        words = newWords
    }
    
    
    public static func getLapCounter() -> Int {
        return lapCounter
    }
    
    public static func incrementLapCounter() -> Void {
        lapCounter = lapCounter + 1
    }
    
    
    public static func appendValueInSavedArrayCheckValue(arrayCheckedValues:[Int]) -> Void {
        SavecheckValuesGame.append(arrayCheckedValues)
    }
    

}
