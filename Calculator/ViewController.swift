//
//  ViewController.swift
//  Calculator
//
//  Created by Taylor Mott on 10/29/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var displayLabel = UILabel()
    var isTypingNumber = false
    var displayValue: Float {
        get {
            let text = displayLabel.text ?? "0"
            return (text as NSString).floatValue
        }
        
        set {
            displayLabel.text = "\(newValue)"
            isTypingNumber = false
        }
    }
    var stack = Stack()
    
    let button0 = UIButton()
    let button1 = UIButton()
    let button2 = UIButton()
    let button3 = UIButton()
    let button4 = UIButton()
    let button5 = UIButton()
    let button6 = UIButton()
    let button7 = UIButton()
    let button8 = UIButton()
    let button9 = UIButton()
    let buttonDiv = UIButton()
    let buttonMult = UIButton()
    let buttonSub = UIButton()
    let buttonAdd = UIButton()
    let buttonEnter = UIButton()
    
    var buttonArray: [UIButton] = []
    var buttonWidthArray: [UIButton] = []
    var buttonNumberArray: [UIButton] = []
    var buttonOperatorArray: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonArray = [button0, button1, button2, button3, button4, button5, button6, button7, button8, button9, buttonDiv, buttonMult, buttonSub, buttonAdd, buttonEnter]
        buttonWidthArray = [button1, button2, button3, button4, button5, button6, button7, button8, button9, buttonDiv, buttonMult, buttonSub, buttonAdd, buttonEnter]
        buttonNumberArray = [button0, button1, button2, button3, button4, button5, button6, button7, button8, button9]
        buttonOperatorArray = [buttonDiv, buttonMult, buttonSub, buttonAdd]
        setupLabel()
        setupNumberButtons()
        setupOperatorButtons()
        setupConstraints()
        
    }
    
    func buttonTapped(button: UIButton) {
        
        guard let digit = button.currentTitle else { return }
        
        if isTypingNumber {
            var calculatorLabel = displayLabel.text ?? ""
            calculatorLabel = calculatorLabel + digit
        } else {
            displayLabel.text = digit
            isTypingNumber = true
        }
    }
    
    func enter() {
        isTypingNumber = false
        stack.push(displayValue)
        stack.log()
        
    }
    
    /*********************************************/
    /*********************************************/
    /************ BUTTON/LABEL SET-UP ************/
    /*********************************************/
    /*********************************************/
    
    // Set up label
    func setupLabel() {
        displayLabel.backgroundColor = .blackColor()
        view.addSubview(displayLabel)
        for button in buttonArray {
            view.addSubview(button)
        }
        displayLabel.font = displayLabel.font.fontWithSize(50)
        displayLabel.textAlignment = .Center
        displayLabel.textColor = .whiteColor()
        displayLabel.text = ""
    }
    
    // Set up number buttons
    func setupNumberButtons() {
        for button in buttonNumberArray {
            button.backgroundColor = .grayColor()
            button.layer.borderColor = UIColor.darkGrayColor().CGColor
            button.layer.borderWidth = 1.5
        }
        
        // Number button titles
        button0.setTitle("0", forState: .Normal)
        button1.setTitle("1", forState: .Normal)
        button2.setTitle("2", forState: .Normal)
        button3.setTitle("3", forState: .Normal)
        button4.setTitle("4", forState: .Normal)
        button5.setTitle("5", forState: .Normal)
        button6.setTitle("6", forState: .Normal)
        button7.setTitle("7", forState: .Normal)
        button8.setTitle("8", forState: .Normal)
        button9.setTitle("9", forState: .Normal)
        
        // Number button target actions
        button0.addTarget(self, action: #selector(buttonTapped), forControlEvents: .TouchUpInside)
        button1.addTarget(self, action: #selector(buttonTapped), forControlEvents: .TouchUpInside)
        button2.addTarget(self, action: #selector(buttonTapped), forControlEvents: .TouchUpInside)
        button3.addTarget(self, action: #selector(buttonTapped), forControlEvents: .TouchUpInside)
        button4.addTarget(self, action: #selector(buttonTapped), forControlEvents: .TouchUpInside)
        button5.addTarget(self, action: #selector(buttonTapped), forControlEvents: .TouchUpInside)
        button6.addTarget(self, action: #selector(buttonTapped), forControlEvents: .TouchUpInside)
        button7.addTarget(self, action: #selector(buttonTapped), forControlEvents: .TouchUpInside)
        button8.addTarget(self, action: #selector(buttonTapped), forControlEvents: .TouchUpInside)
        button9.addTarget(self, action: #selector(buttonTapped), forControlEvents: .TouchUpInside)
        
    }
    
    // Set up operator buttons
    func setupOperatorButtons() {
        for button in buttonOperatorArray {
            button.backgroundColor = .orangeColor()
            button.layer.borderColor = UIColor.darkGrayColor().CGColor
            button.layer.borderWidth = 1.5
        }
        
        buttonEnter.backgroundColor = UIColor.init(red: 0.292, green: 0.576, blue: 0.383, alpha: 1.0)
        buttonEnter.layer.borderColor = UIColor.darkGrayColor().CGColor
        buttonEnter.layer.borderWidth = 1.5
        
        // operator button titles
        buttonDiv.setTitle("÷", forState: .Normal)
        buttonMult.setTitle("x", forState: .Normal)
        buttonSub.setTitle("-", forState: .Normal)
        buttonAdd.setTitle("+", forState: .Normal)
        buttonEnter.setTitle("=", forState: .Normal)
        
        // operator button target actions
        buttonDiv.addTarget(self, action: #selector(buttonTapped), forControlEvents: .TouchUpInside)
        buttonMult.addTarget(self, action: #selector(buttonTapped), forControlEvents: .TouchUpInside)
        buttonSub.addTarget(self, action: #selector(buttonTapped), forControlEvents: .TouchUpInside)
        buttonAdd.addTarget(self, action: #selector(buttonTapped), forControlEvents: .TouchUpInside)
    }
    
    func operatorButton(button: UIButton) {
        guard let operation = button.currentTitle else { return }
        
        if isTypingNumber {
            enter()
        }
        
        if stack.count() >= 2 {
            let float1 = stack.pop()!
            let float2 = stack.pop()!
            
            switch operation {
            case "÷":
                displayValue = float2 / float1
            case "✕":
                displayValue = float2 * float1
            case "−":
                displayValue = float2 - float1
            case "+":
                displayValue = float2 + float1
            default:
                stack.push(float1)
                stack.push(float2)
                
            }
            
            enter()
        }
    }
    
    /*************************************/
    /*************************************/
    /************ CONSTRAINTS ************/
    /*************************************/
    /*************************************/
    
    func setupConstraints() {
        displayLabel.translatesAutoresizingMaskIntoConstraints = false
        button0.translatesAutoresizingMaskIntoConstraints = false
        button1.translatesAutoresizingMaskIntoConstraints = false
        button2.translatesAutoresizingMaskIntoConstraints = false
        button3.translatesAutoresizingMaskIntoConstraints = false
        button4.translatesAutoresizingMaskIntoConstraints = false
        button5.translatesAutoresizingMaskIntoConstraints = false
        button6.translatesAutoresizingMaskIntoConstraints = false
        button7.translatesAutoresizingMaskIntoConstraints = false
        button8.translatesAutoresizingMaskIntoConstraints = false
        button9.translatesAutoresizingMaskIntoConstraints = false
        buttonDiv.translatesAutoresizingMaskIntoConstraints = false
        buttonMult.translatesAutoresizingMaskIntoConstraints = false
        buttonSub.translatesAutoresizingMaskIntoConstraints = false
        buttonAdd.translatesAutoresizingMaskIntoConstraints = false
        buttonEnter.translatesAutoresizingMaskIntoConstraints = false
        
        /*******************************************/
        /************ LABEL CONSTRAINTS ************/
        /*******************************************/
        
        let displayLabelWidth = NSLayoutConstraint(item: displayLabel, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1.0, constant: 0)
        let displayLabelHeight = NSLayoutConstraint(item: displayLabel, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: 0.3, constant: 0)
        let displayLabelTop = NSLayoutConstraint(item: displayLabel, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: 0)
        
        view.addConstraints([displayLabelWidth, displayLabelHeight, displayLabelTop])
        
        /****************************************************/
        /************ TOP ROW BUTTON CONSTRAINTS ************/
        /****************************************************/
        
        // LEADING & TRAILING
        let button7Leading = NSLayoutConstraint(item: button7, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1.0, constant: 0)
        let button8Leading = NSLayoutConstraint(item: button8, attribute: .Leading, relatedBy: .Equal, toItem: button7, attribute: .Trailing, multiplier: 1.0, constant: 0)
        let button9Leading = NSLayoutConstraint(item: button9, attribute: .Leading, relatedBy: .Equal, toItem: button8, attribute: .Trailing, multiplier: 1.0, constant: 0)
        let buttonDivLeading = NSLayoutConstraint(item: buttonDiv, attribute: .Leading, relatedBy: .Equal, toItem: button9, attribute: .Trailing, multiplier: 1.0, constant: 0)
        let buttonDivTrailing = NSLayoutConstraint(item: buttonDiv, attribute: .Trailing, relatedBy: .Equal, toItem: view, attribute: .Trailing, multiplier: 1.0, constant: 0)
        
        view.addConstraints([button7Leading, button8Leading, button9Leading, buttonDivLeading, buttonDivTrailing])
        
        // TOP & BOTTOM
        let button7Top = NSLayoutConstraint(item: button7, attribute: .Top, relatedBy: .Equal, toItem: displayLabel, attribute: .Bottom, multiplier: 1.0, constant: 0)
        let button8Top = NSLayoutConstraint(item: button8, attribute: .Top, relatedBy: .Equal, toItem: displayLabel, attribute: .Bottom, multiplier: 1.0, constant: 0)
        let button9Top = NSLayoutConstraint(item: button9, attribute: .Top, relatedBy: .Equal, toItem: displayLabel, attribute: .Bottom, multiplier: 1.0, constant: 0)
        let buttonDivTop = NSLayoutConstraint(item: buttonDiv, attribute: .Top, relatedBy: .Equal, toItem: displayLabel, attribute: .Bottom, multiplier: 1.0, constant: 0)
        
        view.addConstraints([button7Top, button8Top, button9Top, buttonDivTop])
        
        /*******************************************************/
        /************ SECOND ROW BUTTON CONSTRAINTS ************/
        /*******************************************************/
        
        // LEADING & TRAILING
        let button4Leading = NSLayoutConstraint(item: button4, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1.0, constant: 0)
        let button5Leading = NSLayoutConstraint(item: button5, attribute: .Leading, relatedBy: .Equal, toItem: button4, attribute: .Trailing, multiplier: 1.0, constant: 0)
        let button6Leading = NSLayoutConstraint(item: button6, attribute: .Leading, relatedBy: .Equal, toItem: button5, attribute: .Trailing, multiplier: 1.0, constant: 0)
        let buttonMultLeading = NSLayoutConstraint(item: buttonMult, attribute: .Leading, relatedBy: .Equal, toItem: button6, attribute: .Trailing, multiplier: 1.0, constant: 0)
        let buttonMultTrailing = NSLayoutConstraint(item: buttonMult, attribute: .Trailing, relatedBy: .Equal, toItem: view, attribute: .Trailing, multiplier: 1.0, constant: 0)
        
        view.addConstraints([button4Leading, button5Leading, button6Leading, buttonMultLeading, buttonMultTrailing])
        
        // TOP & BOTTOM
        let button4Top = NSLayoutConstraint(item: button4, attribute: .Top, relatedBy: .Equal, toItem: button7, attribute: .Bottom, multiplier: 1.0, constant: 0)
        let button5Top = NSLayoutConstraint(item: button5, attribute: .Top, relatedBy: .Equal, toItem: button8, attribute: .Bottom, multiplier: 1.0, constant: 0)
        let button6Top = NSLayoutConstraint(item: button6, attribute: .Top, relatedBy: .Equal, toItem: button9, attribute: .Bottom, multiplier: 1.0, constant: 0)
        let buttonMultTop = NSLayoutConstraint(item: buttonMult, attribute: .Top, relatedBy: .Equal, toItem: buttonDiv, attribute: .Bottom, multiplier: 1.0, constant: 0)
        
        view.addConstraints([button4Top, button5Top, button6Top, buttonMultTop])
        
        /******************************************************/
        /************ THIRD ROW BUTTON CONSTRAINTS ************/
        /******************************************************/
        
        // LEADING & TRAILING
        let button1Leading = NSLayoutConstraint(item: button1, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1.0, constant: 0)
        let button2Leading = NSLayoutConstraint(item: button2, attribute: .Leading, relatedBy: .Equal, toItem: button1, attribute: .Trailing, multiplier: 1.0, constant: 0)
        let button3Leading = NSLayoutConstraint(item: button3, attribute: .Leading, relatedBy: .Equal, toItem: button2, attribute: .Trailing, multiplier: 1.0, constant: 0)
        let buttonSubLeading = NSLayoutConstraint(item: buttonSub, attribute: .Leading, relatedBy: .Equal, toItem: button3, attribute: .Trailing, multiplier: 1.0, constant: 0)
        let buttonSubTrailing = NSLayoutConstraint(item: buttonSub, attribute: .Trailing, relatedBy: .Equal, toItem: view, attribute: .Trailing, multiplier: 1.0, constant: 0)
        
        view.addConstraints([button1Leading, button2Leading, button3Leading, buttonSubLeading, buttonSubTrailing])
        
        // TOP & BOTTOM
        let button1Top = NSLayoutConstraint(item: button1, attribute: .Top, relatedBy: .Equal, toItem: button4, attribute: .Bottom, multiplier: 1.0, constant: 0)
        let button2Top = NSLayoutConstraint(item: button2, attribute: .Top, relatedBy: .Equal, toItem: button5, attribute: .Bottom, multiplier: 1.0, constant: 0)
        let button3Top = NSLayoutConstraint(item: button3, attribute: .Top, relatedBy: .Equal, toItem: button6, attribute: .Bottom, multiplier: 1.0, constant: 0)
        let buttonSubTop = NSLayoutConstraint(item: buttonSub, attribute: .Top, relatedBy: .Equal, toItem: buttonMult, attribute: .Bottom, multiplier: 1.0, constant: 0)
        
        view.addConstraints([button1Top, button2Top, button3Top, buttonSubTop])
        
        /*******************************************************/
        /************ BOTTOM ROW BUTTON CONSTRAINTS ************/
        /*******************************************************/
        
        // LEADING & TRAILING
        let button0Leading = NSLayoutConstraint(item: button0, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1.0, constant: 0)
        let buttonEnterLeading = NSLayoutConstraint(item: buttonEnter, attribute: .Leading, relatedBy: .Equal, toItem: button0, attribute: .Trailing, multiplier: 1.0, constant: 0)
        let buttonAddLeading = NSLayoutConstraint(item: buttonAdd, attribute: .Leading, relatedBy: .Equal, toItem: buttonEnter, attribute: .Trailing, multiplier: 1.0, constant: 0)
        let buttonAddTrailing = NSLayoutConstraint(item: buttonAdd, attribute: .Trailing, relatedBy: .Equal, toItem: view, attribute: .Trailing, multiplier: 1.0, constant: 0)
        
        view.addConstraints([button0Leading, buttonEnterLeading, buttonAddLeading, buttonAddTrailing])
        
        // TOP & BOTTOM
        let button0Top = NSLayoutConstraint(item: button0, attribute: .Top, relatedBy: .Equal, toItem: button1, attribute: .Bottom, multiplier: 1.0, constant: 0)
        let buttonEnterTop = NSLayoutConstraint(item: buttonEnter, attribute: .Top, relatedBy: .Equal, toItem: button3, attribute: .Bottom, multiplier: 1.0, constant: 0)
        let buttonAddTop = NSLayoutConstraint(item: buttonAdd, attribute: .Top, relatedBy: .Equal, toItem: buttonSub, attribute: .Bottom, multiplier: 1.0, constant: 0)
        
        view.addConstraints([button0Top, buttonEnterTop, buttonAddTop])
        
        /***************************************************/
        /************ BUTTON HEIGHT CONSTRAINTS ************/
        /***************************************************/
        
        for button in buttonArray {
            let buttonHeight = NSLayoutConstraint(item: button, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: 0.7 / 4, constant: 0)
            
            view.addConstraint(buttonHeight)
        }
        
        /**************************************************/
        /************ BUTTON WIDTH CONSTRAINTS ************/
        /**************************************************/
        
        for button in buttonWidthArray {
            let buttonWidth = NSLayoutConstraint(item: button, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 0.25, constant: 0)
            
            view.addConstraint(buttonWidth)
        }
        
        let button0Width = NSLayoutConstraint(item: button0, attribute: .Width, relatedBy: .Equal, toItem: button7, attribute: .Width, multiplier: 2.0, constant: 0)
        
        view.addConstraint(button0Width)
        
    }
    
}





































