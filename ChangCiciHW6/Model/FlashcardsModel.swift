//
//  FlashcardsModel.swift
//
//  Created by cici on 2022/2/26.
//

import Foundation

class FlashcardsModel: NSObject, FlashcardsDataModel {
  
    // an array containing Flashcard objects
    private var flashcards : [Flashcard]
    // keep track of the current card displaying
    private var currentIndex: Int?
    // keep track of whether a question or answer is currently being displayed
    var questionDisplayed: Bool
    
    let USER_DEFAULTS_FLASHCARDS = "FlashcardsArray"
    var flashcardsFilepath: String
    
    // Swift Singleton pattern
    static let sharedInstance = FlashcardsModel()
    
    override init(){
    
        self.flashcards = [Flashcard]()
        // add five flashcards
        self.flashcards.append(Flashcard(question: "Where is the capital city of Canada?", answer: "Ottawa", isFavorite: false))
        self.flashcards.append(Flashcard(question: "Where is the capital city of Switzerland?", answer: "Bern", isFavorite: true))
        self.flashcards.append(Flashcard(question: "Where is the capital city of Turkey?", answer: "Ankara", isFavorite: true))
        self.flashcards.append(Flashcard(question: "Where is the capital city of Morocco?", answer: "Rabat", isFavorite: true))
        self.flashcards.append(Flashcard(question: "Where is the capital city of Brazil?", answer: "Brasilia", isFavorite: true))
        if flashcards.count == 0 {
            self.currentIndex = nil
        } else{
            self.currentIndex = 0
        }
        self.questionDisplayed = true
        

        // Get the path of the document folder
        let documentFolderPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        flashcardsFilepath = "\(documentFolderPath.first!)/quotes.json"
        
    }

    
    // Take our array of quotes, encode them from an array of native swift objects into a JSON array
    func save(){
        let encoder = JSONEncoder()
        do{
            let data = try encoder.encode(flashcards)
            // Convert data to JSON string
            let str = String(data: data, encoding: .utf8)!
            // Get the path of the document folder
            let filePath = URL(string: flashcardsFilepath)!

            try! str.write(to: filePath, atomically: true, encoding: .utf8)

        } catch{
            print("there is an error with encoding \(error)")
        }
    }
    
   
    

    // Returns number of flashcards in model
    func numberOfFlashcards() -> Int {
        return flashcards.count
    }
    
    // Returns a flashcard – sets currentIndex appropriately
    func randomFlashcard() -> Flashcard? {
        var randomCardIndex : Int?
        if flashcards.isEmpty {
            return nil
        }else {
            if flashcards.count == 1{
                randomCardIndex = Int.random(in: 0...flashcards.endIndex - 1)
            }
            else{
                repeat{
                    randomCardIndex = Int.random(in: 0...flashcards.endIndex - 1)
                }while (randomCardIndex == currentIndex)
            }
            currentIndex = randomCardIndex
            return flashcards[randomCardIndex!]
        }
    }
    
    
    func nextFlashcard() -> Flashcard? {
        if flashcards.isEmpty{
            return nil
        } else{
            if (currentIndex! == flashcards.count - 1){
                currentIndex! = 0
            } else{
                currentIndex! += 1
            }
            return flashcards[currentIndex!]
        }
    }
    
    func previousFlashcard() -> Flashcard? {
        if flashcards.isEmpty{
            return nil
        }else{
            if (currentIndex! == 0){
                currentIndex = flashcards.count - 1
            }else {
                currentIndex! -= 1
            }
            return flashcards[currentIndex!]
        }
    }
    
    //Returns a card at a given index
    func flashcard(at index: Int) -> Flashcard? {
        if (index >= 0) && (index < flashcards.count) {
            return flashcards[index]
        }
        return nil
    }
    
    // Removed! Inserts a flashcard – sets currentIndex appropriately when inserting to certain positions
//    func insert(question: String, answer: String, favorite: Bool) {
//        flashcards.append(Flashcard(question: question, answer: answer, isFavorite: favorite))
//    }
    
    // This function should remove the card from the index at which it is found, and inserted wherever it was dragged to.
    func rearrageFlashcards(from: Int, to: Int){
        if flashcards.isEmpty{
            print("Error: it is empty!")
        } else if (from < 0 || from >= flashcards.endIndex){
            print("Error: from index is out of bond!")
        } else if (to < 0 || to >= flashcards.endIndex){
            print("Error: to index is out of bond!")
        }
        let card = flashcards.remove(at: from)
        flashcards.insert(card, at: to)
    }
    
    // check if the question you are about to add has already been asked
    func checkAskedQuestion(potentialQuestion: String) -> Bool {
        var exist : Bool = false
        // loop through exisiting flashcards
        for card in flashcards{
            if card.getQuestion().lowercased().contains(potentialQuestion){
                exist = true
            } else{
                exist = false
            }
        }
        return exist
    }
    
    func insert(question: String, answer: String, favorite: Bool, at index: Int) {
        // the cases when the index is in the range and when the index is one number greater than the end of the list
        if (index <= flashcards.endIndex) && (index >= 0){
            flashcards.insert(Flashcard(question: question, answer: answer, isFavorite: favorite), at: index)
            if currentIndex == nil{
                currentIndex = index
            } else{
                if index <= currentIndex! {
                    currentIndex! += 1
                }
            }
        }else{
            print("Error! The index is out of range.")
        }
    }
        
    
    
    // Returns the current flashcard at currentIndex
    func currentFlashcard() -> Flashcard? {
        if flashcards.isEmpty{
            return nil
        }
        return flashcards[currentIndex!]
    }
    
    // Removes a flashcard – sets currentIndex appropriately when removing from certain positions
    func removeFlashcard(at index: Int) {
        if flashcards.isEmpty{
            currentIndex = nil
        } else{
            if (index <= flashcards.count - 1) && (index >= 0){
                if flashcards.count == 1{
                    currentIndex = nil
                } else{
                    if index < currentIndex!{
                        currentIndex! -= 1
                    }else if index == currentIndex{
                        if currentIndex == flashcards.count - 1{
                            currentIndex! -= 1
                        }
                    }
                }
                flashcards.remove(at: index)
            }else{
                print("Error! Out of range!")
            }
        }

    }
    
    func favoriteFlashcards() -> [Flashcard] {
        var favFlashcard = [Flashcard]()
        for i in (0..<flashcards.count){
            if flashcards[i].isFavorite{
                favFlashcard.append(flashcards[i])
            }
        }
        return favFlashcard
    }
    
    func toggleFavorite() {
        if let index = currentIndex{
            flashcards[index].isFavorite.toggle()
        }
    }
    
    // helper method to remove cards from favorite list
    func removeFav(favFlash:[Flashcard], index: Int){
//        let favFlash = favoriteFlashcards()
        let cardAboutToBeRemoved = favFlash[index]
        let originalIndex = flashcards.firstIndex(where: {$0 == cardAboutToBeRemoved})
        flashcards[originalIndex!].isFavorite.toggle()
    }
}
