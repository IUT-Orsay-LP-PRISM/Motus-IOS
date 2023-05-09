//
//  Game.swift
//  motus_programmation
//
//  Created by Romain Fromentin on 09/05/2023.
//

import Foundation
class Game {
    
    public static var chosenWord: String = "meldois"
    public static var words : [String] = []
    
    public static func verifyWord(inputWord: String){
        // 0 : pas dans le mot
        // 1 : pas au bon endroit
        // 2 : bon endroit
        var answers : [Int] = []
        
        // On enlève au fur et à mesure les lettres déjà vérifiées
        var tempChosenWord = tablify(word: chosenWord.uppercased())
        let word = tablify(word: chosenWord.uppercased())
        let tempInputWord = tablify(word: inputWord.uppercased())
        
        for i in 0..<tempInputWord.count{
            if word[i] == tempInputWord[i] {
                answers.append(2)
                // On enlève la lettre de notre tableau de charactères, ce qui évite les doublon
                tempChosenWord.remove(at: tempChosenWord.firstIndex(of: tempInputWord[i]) ?? 0)
            }else if tempChosenWord.contains(tempInputWord[i]){
                // On teste si la lettre existe dans la fin du mot afin d'éviter les doublons
                var alreadyInEnd = false
                // Pour éviter les erreurs, on check que le i n'est pas à la fin du mot
                if(i < tempInputWord.count-1){
                    alreadyInEnd = !tempInputWord[i+1..<tempInputWord.count].contains(tempInputWord[i])
                }
                if(alreadyInEnd){
                    answers.append(1)
                    // On enlève la lettre de notre tableau de charactères, ce qui évite les doublon
                    tempChosenWord.remove(at: tempChosenWord.firstIndex(of: tempInputWord[i]) ?? 0)
                }else{
                    // Si la lettre est contenue dans le mot, mais avant le i
                    answers.append(0)
                }
            }else{
                answers.append(0)
            }
        }
        
        // On remet les valeurs par dessus, au cas où il y aurait des erreurs
        for i in 0..<tempInputWord.count{
            if word[i] == tempInputWord[i] {
                answers[i] = 2
            }
        }
        // Affichage transformable en retour de tableau
        print(answers)
    }
    
    // Transformer les mots en tableaux, puisque Swift ne veut pas utiliser les String comme des tableaux de charactères
    public static func tablify(word: String)-> [Character]{
        var tempWord = word
        var letters : [Character] = []
        for char in word{
            letters.append(char)
            tempWord.remove(at: tempWord.startIndex)
        }
        return letters
    }
    
}
