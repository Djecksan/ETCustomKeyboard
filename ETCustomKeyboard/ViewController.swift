//
//  ViewController.swift
//  ETCustomKeyboard
//
//  Created by Evgenyi Tyulenev on 29.09.14.
//  Copyright (c) 2014 TulenevCode. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    var keyboardView : ETCustomKeyboard!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        keyboardView = ETCustomKeyboard.loadFromNibNamed("ETCustomKeyboard")
        keyboardView.textInput = textField
//        ETCustomKeyboard.loadKeyboard(textField)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

