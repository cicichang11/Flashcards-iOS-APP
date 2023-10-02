//
//  FlashcardModel.swift
//

import Foundation

//used for the data model
protocol FlashcardsDataModel {
    func numberOfFlashcards() -> Int
    func randomFlashcard() -> Flashcard?
    //modified function to not set currentindex
    func flashcard(at index: Int) -> Flashcard?
    func nextFlashcard() -> Flashcard?
    func previousFlashcard() -> Flashcard?
    //removed function
    //func insert(question: String,
       //         answer: String,
         //       favorite: Bool)
    func insert(question: String,
                answer: String,
                favorite: Bool,
                at index: Int)
    func currentFlashcard() -> Flashcard?
    func removeFlashcard(at index: Int)
    func toggleFavorite()
    func favoriteFlashcards() -> [Flashcard]
    
    //added functions
    func rearrageFlashcards(from: Int, to: Int)
    func checkAskedQuestion(potentialQuestion: String) -> Bool
}


