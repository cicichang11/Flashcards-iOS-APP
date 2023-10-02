//
//  FavoritesTableViewController.swift
//  ChangCiciHW6
//
//  Created by cici on 2022/3/21.
//

import UIKit

class FavoritesTableViewController: UITableViewController {
    
    let flashCard = FlashcardsModel.sharedInstance
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return flashCard.favoriteFlashcards().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavQuestionCell")
        
        // modify the cell
        let favQuestion = flashCard.favoriteFlashcards()[indexPath.row]
       
        cell?.textLabel?.text = favQuestion.getQuestion()
        cell?.detailTextLabel?.text = favQuestion.getAnswer()
        
        return cell!
        
    }
    
    // delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        // delete / unfav
        if editingStyle == .delete{
            
            // unfav the card
            let row = indexPath.row
            flashCard.removeFav(favFlash: flashCard.favoriteFlashcards(), index: row)
//            let removedQuestion = flashCard.flashcard(at: row)?.getQuestion()
//            let removedAnswer = flashCard.flashcard(at: row)?.getAnswer()
//            flashCard.removeFlashcard(at: row)
//            flashCard.insert(question: removedQuestion!, answer: removedAnswer!, favorite: false, at: row)
            
            
            
            // delete the row from data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
    }
    
    // move position
    override func tableView(_ tableView: UITableView, moveRowAt
                            fromIndexPath: IndexPath, to: IndexPath){
        flashCard.rearrageFlashcards(from: fromIndexPath.row, to: to.row)
    }
}
