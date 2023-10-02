//
//  ChangCiciHW5Tests.swift
//  ChangCiciHW5Tests
//
//  Created by cici on 2022/2/26.
//

import XCTest
@testable import ChangCiciHW5

class ChangCiciHW5Tests: XCTestCase {
    
    var flashCardTest : FlashcardsModel!
    
    override func setUp(){
        flashCardTest = FlashcardsModel()
    }
    
    func testSharedModel(){
        let model1 = FlashcardsModel.sharedInstance
        let model2 = FlashcardsModel.sharedInstance
        
        // modify model 1
        model1.insert(question: "What's the capital city of mexico?", answer: "Mexico City", favorite: true)
        
        let modelOneCurrent = model1.currentFlashcard()
        let modelTwoCurrent = model2.currentFlashcard()
        XCTAssertEqual(modelOneCurrent, modelTwoCurrent)
    }
    
    // test the numberOfFlashCards function
    func flashCardsTestNumberOfFlashCards(){
        let numFlashCards : Int = flashCardTest.numberOfFlashcards()
        XCTAssertTrue(numFlashCards == 5)
    }
    
    // test the randomFlashcard function
    func flashCardsTestRandomFlashcard(){
        let currentCardBeforeRandom = flashCardTest.currentFlashcard()
        let randomCardGenerated = flashCardTest.randomFlashcard()
        XCTAssertNotEqual(currentCardBeforeRandom, randomCardGenerated)
    }
    
    // test the nextFlashcard function
    func flashCardsTestNextFlashcard(){
        let currentCard = flashCardTest.currentFlashcard()
        let nextCard = flashCardTest.nextFlashcard()
        
        XCTAssertNotEqual(nextCard, currentCard)
    }
    
    // test the previousCard function
    func flashCardsTestPreviousFlashcard(){
        let currentCard = flashCardTest.currentFlashcard()
        let prevCard = flashCardTest.previousFlashcard()
        
        XCTAssertNotEqual(prevCard, currentCard)
    }
    
    // test the flashcard(at:) function
    func flashCardTestFlashcardAt(){
        let theCard = flashCardTest.flashcard(at: 0)
        
        XCTAssertEqual("Where is the capital city of Canada?", theCard!.getQuestion())
    }
    
    // test the insert fuction (without index)
    func flashCardTestInsertWithoutIndex(){
        flashCardTest.insert(question: "What's the color of apples?", answer: "red", favorite: true)
        
        // get the number of card
        let numCardsAfterInserting : Int = flashCardTest.numberOfFlashcards()
        XCTAssertTrue(numCardsAfterInserting == 6)
    }
    
    // test the insert function (with index)
    func flashCardTestInsertWithIndex(){
        flashCardTest.insert(question: "What's the color of apples?", answer: "red", favorite: true, at:3)
        // get the number of card
        let numCardsAfterInserting : Int = flashCardTest.numberOfFlashcards()
        XCTAssertTrue(numCardsAfterInserting == 6)
    }
    
    // test the currentFlashcard function
    func flashCardTestCurrentFlashCard(){
        let cardBeforeChange = flashCardTest.currentFlashcard()
        _ = flashCardTest.previousFlashcard()
        let cardAfterChange = flashCardTest.currentFlashcard()
        
        XCTAssertNotEqual(cardAfterChange, cardBeforeChange)
    }

    // test the removeFlashcard function
    func flashCardTestRemoveFlashcard(){
        flashCardTest.removeFlashcard(at: 1)
        // get the number of card
        let numCardsAfterRemoving : Int = flashCardTest.numberOfFlashcards()
        XCTAssertTrue(numCardsAfterRemoving == 4)
    }
    
    // test the toggleFavorite function
    func flashCardTestToggleFavorite(){
        // card before toggle favorite
        let originalCard = flashCardTest.flashcard(at: 2)
        flashCardTest.toggleFavorite()
        // after toggle favorite
        let newCard = flashCardTest.flashcard(at: 2)
        
        // they should not be equal
        XCTAssertNotEqual(originalCard, newCard)
    }
    
    // test the favoriteFlashcards function
    func flashCardTestFavoriteFlashcards(){
        // list of fav cards
        let favCards = flashCardTest.favoriteFlashcards()
        let numFavCards : Int = favCards.count
        
        XCTAssertTrue(numFavCards <= 5)
    }
}
