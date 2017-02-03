//
//  ViewController.swift
//  EZWhatsTheNumber
//
//  Created by Leo on 2017/2/2.
//  Copyright © 2017年 Leo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var msgLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    
    // Can guess the maximum/minimum number
    var maxNumber:Int = 0
    var minNumber:Int = 0
    var anser:Int     = 0
    var isOver:Bool   = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init variable
        maxNumber = 100
        minNumber = 1
        
        // arc4random_uniform() -> unsinged int 32bit -> 4bytes
        anser = Int(arc4random_uniform(100) + 1)
        
        // push the keyboard up
        inputTextField.becomeFirstResponder()
    }
    
    @IBAction func guessBtnDidClick(_ sender: UIButton) {
        print("anser: \(anser)")
        
        if isOver {
            // Game is over, reset variable
            isOver = false;
            maxNumber = 100
            minNumber = 1
            anser = Int(arc4random_uniform(100) + 1)
            msgLabel.text = "Guess a number between \(minNumber) ~ \(maxNumber)"
            sender.setTitle("Guess", for: .normal)
            return;
        }
        
        // Take input text out
        let inputText = inputTextField.text!
        
        // If no input avoid application crash
        if inputText == "" {
            // no input
            msgLabel.text = "No input! Guess a number between \(minNumber) ~ \(maxNumber)"
        }
        else {
            // Change variable type to compare
            let inputNumber:Int = Int(inputText)!
//            print("inputNumber: \(inputNumber)")
            
            if inputNumber > maxNumber {
                // Too large
                msgLabel.text = "Too large! Guess a number between \(minNumber) ~ \(maxNumber)"
            }
            else if inputNumber < minNumber {
                // Too small
                msgLabel.text = "Too Small! Guess a number between \(minNumber) ~ \(maxNumber)"
            }
            else {
                // Check anser
                if inputNumber == anser {
                    // Bingo!! Right anser
                    msgLabel.text = "You are right!! Press \"Reset\" to play again."
                    isOver = true;
                    sender.setTitle("Reset", for: .normal)
                }
                else {
                    // Wrong anser
                    if inputNumber > anser {
                        // Larger than anser
                        maxNumber = inputNumber
                    }
                    else {
                        // Smaller than anser
                        minNumber = inputNumber
                    }
                    msgLabel.text = "Try again! Guess a number between \(minNumber) ~ \(maxNumber)"
                }
            }
        }
        
        inputTextField.text = ""
        inputTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

