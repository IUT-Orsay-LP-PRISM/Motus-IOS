//  ListOfWords.swift
//  motus-ios
//
//  Created by Frederic Dabadie on 06/06/2023.
//

import Foundation
class ListOfWords {

    public static var dictionary : [String] = []
    public static var reducedDictionary : [String] = []
    public static var matchWord : String = "unsettedWord"
    
// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
// Charge toutes les mots qui sont dans le fichier ods6 contenant toutes les
// mots disponibles dans le jeu et les affecte à l'attribut "dictionary" de la classe
public static func initDictionnaryArray(){
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
public static func reducedDictionaryByNumberOfLetters(minimumNumberOfLetters: Int, maximumNumberOfLetters: Int) {
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
public static func nsdateToInt(nsdate: Date) -> Int {
    // convert Date to TimeInterval (typealias for Double)
    let timeInterval = nsdate.timeIntervalSince1970

    // convert to Integer
    return Int(timeInterval)
}



// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
// Prends en paramètre un entier et retourne son équivalent en NSDate
public static func intToNSDate(number: Int) -> Date {
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
