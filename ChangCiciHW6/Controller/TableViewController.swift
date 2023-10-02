//
//  TableViewController.swift
//  ChangCiciHW6
//
//  Created by cici on 2022/3/20.
//

import UIKit

class TableViewController: UITableViewController {
    
    @IBOutlet var flashcardsTableView: UITableView!
    @IBOutlet weak var tableNavigation: UINavigationItem!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    let flashCard = FlashcardsModel.sharedInstance
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flashCard.numberOfFlashcards()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell")
        
        // modify the cell
        let question = flashCard.flashcard(at: indexPath.row)
        
        cell?.textLabel?.text = question?.getQuestion()
        cell?.detailTextLabel?.text = question?.getAnswer()
        
        return cell!
    }
    
    // delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        // delete
        if editingStyle == .delete{
            
            // Remove the data from the model
            flashCard.removeFlashcard(at: indexPath.row)
            
            // delete the row from data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
    }
    
    // move position
    override func tableView(_ tableView: UITableView, moveRowAt
                            fromIndexPath: IndexPath, to: IndexPath){
        flashCard.rearrageFlashcards(from: fromIndexPath.row, to: to.row)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    

    @IBAction func editButtonDidTapped(_ sender: UIBarButtonItem) {
        if tableView.isEditing{
            tableView.isEditing = false
            sender.title = "Edit"
        }else {
            tableView.isEditing = true
            sender.title = "Done"
        }
    }
    
}
