//
//  AddViewController.swift
//  ChangCiciHW6
//
//  Created by cici on 2022/3/20.
//

import UIKit

class AddViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    let flashCard = FlashcardsModel.sharedInstance

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var favSwitch: UISwitch!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var isFavLabel: UILabel!
    
    
    var questionTyped : Bool = false
    var answerTyped : Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.questionTextView.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.isEnabled = false
        favSwitch.isOn = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tap(gesture:)))
        self.view.addGestureRecognizer(tapGesture)
//        questionTextView.textContainer.maximumNumberOfLines = 1
    }
    
    func setDefault(){
        favSwitch.isOn = false
    }
    
    // helper
    func enableButtonHelper(){
        if questionTyped && answerTyped {
            saveButton.isEnabled = true
        } else{
            saveButton.isEnabled = false
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)

        let answer = textField == answerTextField ? newString : answerTextField.text!
        
        print("answer \(answer)")
        
        // check whether answer is typed
        if answer.isEmpty {
            answerTyped = false
        } else{
            answerTyped = true
        }
        
        // enable the save button
        enableButtonHelper()
        
        return true
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        answerTextField.resignFirstResponder()
        // questionTextView.becomeFirstResponder()
        return true
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newString = (textView.text! as NSString).replacingCharacters(in: range, with: text)
        
        let question = textView == questionTextView ? newString : questionTextView.text!
        
        print("question \(question)")
    
        // check whether question is typed
        if question.isEmpty {
            questionTyped = false
        } else{
            questionTyped = true
        }
        
        // enable the save button
        enableButtonHelper()
        
//        if (questionTextView.text.count == 1 && questionTextView.text == "\n") {
//            questionTextView.resignFirstResponder()
//            return false;
//        }
        
        
//        let resultRange = questionTextView.text.rangeOfCharacter(from: CharacterSet.newlines, options: .backwards)
//        if questionTextView.text.count != 0 && resultRange != nil {
//            questionTextView.resignFirstResponder()
//            // Do any additional stuff here
//            return false
//        }

        
        // move from text view to text field
        if questionTextView.text == "\n" {
            questionTextView.resignFirstResponder()
            answerTextField.becomeFirstResponder()
            return false
        }
        
        return true
    }

    
    func showSaveButton(){
        if (questionTextView.text.count > 0) && (answerTextField.text!.count > 0) {
            saveButton.isEnabled = true
        } else{
            saveButton.isEnabled = false
        }
    }
    
    @IBAction func cancelButtonDidTapped(_ sender: UIBarButtonItem) {
        questionTextView.text = nil
        answerTextField.text = nil
        self.dismiss(animated: true, completion:{
            //
        })
    }
    
    
    @IBAction func saveButtonDidTapped(_ sender: UIBarButtonItem) {
        if flashCard.checkAskedQuestion(potentialQuestion: questionTextView.text!){
            let alterController = UIAlertController(title: "Warning!", message: "The question you have entered already exists, try a new question", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: okActionHandler)
            alterController.addAction(okAction)
            
            self.present(alterController, animated: true, completion: nil)
            
        } else{
            if favSwitch.isOn{
                flashCard.insert(question: questionTextView.text, answer: answerTextField.text!, favorite: true, at: flashCard.numberOfFlashcards())
            } else{
                flashCard.insert(question: questionTextView.text, answer: answerTextField.text!, favorite: false, at: flashCard.numberOfFlashcards())
            }
            questionTextView.text = nil
            answerTextField.text = nil
            self.dismiss(animated: true, completion:{
                //
            })
            
        }
    }
    
    func okActionHandler(_action: UIAlertAction) -> Void{
        questionTextView.text = nil
        answerTextField.text = nil
    }
    
    // touch outside the textbox
    @objc func tap(gesture: UITapGestureRecognizer) {
        questionTextView.resignFirstResponder()
        answerTextField.resignFirstResponder()
    }
   
}
