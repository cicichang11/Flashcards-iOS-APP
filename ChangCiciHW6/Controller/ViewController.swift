//
//  ViewController.swift
//  ChangCiciHW5
//
//  Created by cici on 2022/2/26.
//

import UIKit

class ViewController: UIViewController {
    let flashCard = FlashcardsModel.sharedInstance
    
    
    @IBOutlet weak var flashCardsLabel: UILabel!
    
    @IBOutlet weak var favStarButton: UIButton!
    
    @IBAction func favButtonDidTapped(_ sender: UIButton) {
        if favStarButton.tintColor == UIColor.yellow{
            favStarButton.tintColor = UIColor.white
            flashCard.toggleFavorite()
        } else{
            favStarButton.tintColor = UIColor.yellow
            flashCard.toggleFavorite()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flashCardsLabel.text = flashCard.randomFlashcard()?.getQuestion()
        //flashCardsLabel.backgroundColor = UIColor.black

        
        // single single tap
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(singleTappedRecognized))
        
        self.view.addGestureRecognizer(singleTap)
        
        // double double tap
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTappedRecognized))
        doubleTap.numberOfTapsRequired = 2
        
        self.view.addGestureRecognizer(doubleTap)
        
        // single & double tap
        singleTap.require(toFail: doubleTap)
        
        // swipe left
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipeGestureRecognized))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        // swipe right
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipeGestureRecognized))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        // fav star button
        self.favStarChangeColor()
    }
    
    // view will appear method
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if flashCard.numberOfFlashcards() == 0{
            flashCardsLabel.text = "There are no more flashcards."
            self.favStarButton.alpha = 0
        }else{
            flashCardsLabel.text = flashCard.currentFlashcard()?.getQuestion()
        }
        self.flashCardsLabel.backgroundColor = UIColor.black
        self.favStarChangeColor()
    }
    
    func favStarChangeColor(){
        if (flashCard.currentFlashcard()?.isFavorite == true) {
            favStarButton.tintColor = UIColor.yellow
        } else{
            favStarButton.tintColor = UIColor.white
        }
    }
    
    // single tap + transform up and down
    @objc func singleTappedRecognized (recognizer: UITapGestureRecognizer){
        // transform up
        let singleTapUpAnimator = UIViewPropertyAnimator(duration: 0.5, curve: .linear){
            self.flashCardsLabel.transform = CGAffineTransform(translationX: 0, y: -900)
            self.favStarButton.transform = CGAffineTransform(translationX: 0, y: -900)
        }
        // change card and transform back
        singleTapUpAnimator.addCompletion{(position) in
            if self.flashCard.numberOfFlashcards() > 0 {
                self.flashCardsLabel.text = self.flashCard.randomFlashcard()?.getQuestion()
                // change star color
                self.favStarChangeColor()
            } else {
                self.flashCardsLabel.text = "There are no more flashcards."
            }
            self.flashCardsLabel.backgroundColor = UIColor.black
            let singleTapBackAnimator = UIViewPropertyAnimator(duration: 0.5, curve: .linear){
                self.flashCardsLabel.transform = CGAffineTransform.identity
                self.favStarButton.transform = CGAffineTransform.identity
                }
            singleTapBackAnimator.startAnimation()
        }
        // first animation display
        singleTapUpAnimator.startAnimation()
    }
    
    // double tap fade out & fade in
    func fadeOut() {
        flashCardsLabel.alpha = 0
        favStarButton.alpha = 0
    }
    
    func fadeIn() {
        flashCardsLabel.alpha = 1
        if flashCard.numberOfFlashcards() == 0{
            self.favStarButton.alpha = 0
        }else{
            self.favStarButton.alpha = 1
        }
    }
    
    @objc func doubleTappedRecognized (recognizer: UITapGestureRecognizer){
        let fadeOutAnimator = UIViewPropertyAnimator(duration: 1, curve: .linear, animations: fadeOut)
        // get the answer/question & fade in
        fadeOutAnimator.addCompletion { (position) in
            // get answer or question
            if self.flashCard.numberOfFlashcards() > 0 {
                if self.flashCardsLabel.text == self.flashCard.currentFlashcard()?.getQuestion(){
                    self.flashCardsLabel.text = self.flashCard.currentFlashcard()?.getAnswer()
                    // change the background color of the answer
                    self.flashCardsLabel.backgroundColor = UIColor.blue
                } else if self.flashCardsLabel.text == self.flashCard.currentFlashcard()?.getAnswer(){
                    self.flashCardsLabel.text = self.flashCard.currentFlashcard()?.getQuestion()
                    // change the background color of the question back to black
                    self.flashCardsLabel.backgroundColor = UIColor.black
                }
            } else{
                if (self.flashCardsLabel.text == "There are no more flashcards."){
                    self.flashCardsLabel.text = "Please add more flashcards."
                    self.flashCardsLabel.backgroundColor = UIColor.blue
                } else if (self.flashCardsLabel.text == "Please add more flashcards."){
                    self.flashCardsLabel.text = "There are no more flashcards."
                    self.flashCardsLabel.backgroundColor = UIColor.black
                }
                // hide the star
                // self.favStarButton.alpha = 0
            }
            
            // fade in
            let fadeInAnimator = UIViewPropertyAnimator(duration: 1, curve: .linear, animations: {() in
                self.fadeIn()
                
            })
            fadeInAnimator.startAnimation()
        }
        fadeOutAnimator.startAnimation()
    }
    
    // transform left, (get next card), move back
    @objc func leftSwipeGestureRecognized(recognizer: UITapGestureRecognizer){
        // transform left
        let swipeLeftAnimator = UIViewPropertyAnimator(duration: 0.5, curve: .linear){
            self.flashCardsLabel.transform = CGAffineTransform(translationX: -300, y: 0)
            self.favStarButton.transform = CGAffineTransform(translationX: -300, y: 0)
        }
        // change card and transform back
        swipeLeftAnimator.addCompletion{(position) in
            // get next card
            if self.flashCard.numberOfFlashcards() > 0{
                self.flashCardsLabel.text = self.flashCard.nextFlashcard()?.getQuestion()
                // change star color
                self.favStarChangeColor()
            } else{
                self.flashCardsLabel.text = "There are no more flashcards."
            }
            self.flashCardsLabel.backgroundColor = UIColor.black
            // move card & button to the far right outside the screen
            self.flashCardsLabel.transform = CGAffineTransform(translationX: 300, y: 0)
            self.favStarButton.transform = CGAffineTransform(translationX: 300, y: 0)
            // move back
            let swipeLeftBackAnimator = UIViewPropertyAnimator(duration: 0.5, curve: .linear){
                self.flashCardsLabel.transform = CGAffineTransform.identity
                self.favStarButton.transform = CGAffineTransform.identity
            }
            swipeLeftBackAnimator.startAnimation()
        }
        // move left display
        swipeLeftAnimator.startAnimation()
    }
    
    // transform right, (get prev card), move back
    @objc func rightSwipeGestureRecognized(recognizer: UITapGestureRecognizer){
        // transform right
        let swipeRightAnimator = UIViewPropertyAnimator(duration: 0.5, curve: .linear){
            self.flashCardsLabel.transform = CGAffineTransform(translationX: 300, y: 0)
            self.favStarButton.transform = CGAffineTransform(translationX: 300, y: 0)
        }
        // change card and transform back
        swipeRightAnimator.addCompletion{(position) in
            // get prev card
            if self.flashCard.numberOfFlashcards() > 0{
                self.flashCardsLabel.text = self.flashCard.previousFlashcard()?.getQuestion()
                // change star color
                self.favStarChangeColor()
            }else{
                self.flashCardsLabel.text = "There are no more flashcards."
            }
            self.flashCardsLabel.backgroundColor = UIColor.black
            // move it to the far left outside the screen
            self.flashCardsLabel.transform = CGAffineTransform(translationX: -300, y: 0)
            self.favStarButton.transform = CGAffineTransform(translationX: -300, y: 0)
            // move back
            let swipeRightBackAnimator = UIViewPropertyAnimator(duration: 0.5, curve: .linear){
                self.flashCardsLabel.transform = CGAffineTransform.identity
                self.favStarButton.transform = CGAffineTransform.identity
            }
            swipeRightBackAnimator.startAnimation()
        }
        // move right display
        swipeRightAnimator.startAnimation()
    }

}
