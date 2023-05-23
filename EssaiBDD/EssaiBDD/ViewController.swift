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


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //let file = "ods6.txt" //this is the file. we will write to and read from it
        
        var contents = ""
        if let filepath = Bundle.main.path(forResource: "ods6", ofType: "txt") {
            do {
                contents = try String(contentsOfFile: filepath)
            } catch {
                // contents could not be loaded
            }
        } else {
            print("filepath marche pas")
        }
        
        // Writes the dictionary = each word of the variable contents is an element of the variable dictionary
        dictionary = contents.components(separatedBy: "\n")
        //print(dictionary)
        //print(contents) // OK


//        let directories = NSSearchPathForDirectoriesInDomains(.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
//        if let documents = directories.first {
//            let cheminFichier = documents.appending("/ods6.txt")
//            print(cheminFichier)
//
//            //reading
//            do {
//                let file = URL(fileURLWithPath: cheminFichier)
//
//                let temporaryDirectory = try FileManager.default.url(
//                    for: .documentDirectory,
//                    in: .userDomainMask,
//                    appropriateFor: file,
//                    create: true
//                )
//
//                let text2 = try String(contentsOf: file, encoding: .utf8)
//                print(text2)
//            }
//            catch {/* error handling here */}
//        }
        

//        do {
//            let temporaryDirectory = try FileManager.default.url(
//                for: .documentDirectory,
//                in: .userDomainMask,
//                appropriateFor: file,
//                create: true
//            )
//
//            print(temporaryDirectory.description)
//        } catch {
//            // Handle the error.
//        }
        reducedDictionaryForNumberOfLetters(minimumNumberOfLetters : 2,maximumNumberOfLetters : 3)
        print(self.reducedDictionary)
    }
    
    func reducedDictionaryForNumberOfLetters(minimumNumberOfLetters: Int, maximumNumberOfLetters: Int) {
        self.reducedDictionary = []
        
        for word in self.dictionary {
            if (word.count >= minimumNumberOfLetters && word.count <= maximumNumberOfLetters) {
                self.reducedDictionary.append(word)
            }
        }
    }


}

