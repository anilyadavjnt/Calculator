//
//  ViewController.swift
//  Calculator
//
//  Created by Anil Yadav on 14/02/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButtonn: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var eightButton: UIButton!
    @IBOutlet weak var nineButton: UIButton!
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var decimalButton: UIButton!
    @IBOutlet weak var allClearButton: UIButton!
    @IBOutlet weak var plusMinusButton: UIButton!
    @IBOutlet weak var percentButton: UIButton!
    @IBOutlet weak var divisionButton: UIButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var equalButton: UIButton!
    @IBOutlet weak var displayLabel: UILabel!
    
    
    private var isTypingNumber = false
    private var previousValue: Double = 0
    private var currentOperation: Operation? = nil

    enum Operation {
        case decimal, add, subtract, multiply, divide, percentage, plusMinus, allClear, none
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        allClearButton.layer.cornerRadius = 8
        plusMinusButton.layer.cornerRadius = 8
        percentButton.layer.cornerRadius = 8
        divisionButton.layer.cornerRadius = 8
        sevenButton.layer.cornerRadius = 8
        eightButton.layer.cornerRadius = 8
        nineButton.layer.cornerRadius = 8
        multiplyButton.layer.cornerRadius = 8
        fourButton.layer.cornerRadius = 8
        fiveButton.layer.cornerRadius = 8
        sixButton.layer.cornerRadius = 8
        minusButton.layer.cornerRadius = 8
        oneButton.layer.cornerRadius = 8
        twoButton.layer.cornerRadius = 8
        threeButtonn.layer.cornerRadius = 8
        plusButton.layer.cornerRadius = 8
        
        zeroButton.layer.cornerRadius = 8
        decimalButton.layer.cornerRadius = 8
        equalButton.layer.cornerRadius = 8
        
    }

    //MARK: - Buttons Action
    //MARK: Number Pressed Action
    @IBAction func numberPressed(_ sender: UIButton) {
        if let numberText = sender.currentTitle {
            if isTypingNumber {
                displayLabel.text! += numberText
            } else {
                displayLabel.text = numberText
                isTypingNumber = true
            }
        }
    }

    //MARK: Operator Pressed Action
    @IBAction func operatorPressed(_ sender: UIButton) {
        if let operation = sender.currentTitle, let value = Double(displayLabel.text!) {
            previousValue = value
            isTypingNumber = false
            switch operation {
            case ".": currentOperation = .decimal
            case "+": currentOperation = .add
            case "-": currentOperation = .subtract
            case "x": currentOperation = .multiply
            case "÷": currentOperation = .divide
            case "%": currentOperation = .percentage
            case "+/-": currentOperation = .plusMinus
            case "AC": currentOperation = .allClear
            default: break
            }
            if operation != "+/-" {
                displayLabel.text = "0"
            }
        }
    }
    
    @IBAction func equalsTapped(_ sender: UIButton) {
        if let value = Double(displayLabel.text!), let operation = currentOperation {
            var result: Double = 0
            switch operation {
            case .decimal:
                if let currentText = displayLabel.text, !currentText.contains(".") {
                    displayLabel.text! += "."
                    isTypingNumber = true
                }
                
            case .add:
                result = previousValue + value
                
            case .subtract:
                result = previousValue - value
                
            case .multiply:
                result = previousValue * value
                
            case .divide:
                result = value != 0 ? previousValue / value : 0
                                
            case .percentage:
                if let value = Double(displayLabel.text!) {
                    result = (value / 100)
                }
                
            case .plusMinus:
                if let value = Double(displayLabel.text!) {
                    result = (-value)
                }
                
            case .allClear:
                displayLabel.text = "0"
                previousValue = 0
                currentOperation = nil
                isTypingNumber = false
                
            case .none: break
            }
            displayLabel.text = String(result)
            currentOperation = nil
            isTypingNumber = false
        }
    }
}

