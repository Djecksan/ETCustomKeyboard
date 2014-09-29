//
//  ETKeyboard.swift
//  ETKeyboard
//
//  Created by Evgenyi Tyulenev on 26.09.14.
//  Copyright (c) 2014 TulenevCode. All rights reserved.
//

import UIKit

class ETCustomKeyboard: UIView, UIInputViewAudioFeedback {
    
    var textInput : UITextInput! {
        didSet {
            if textInput .isKindOfClass(UITextView) {
                (textInput as UITextView).inputView = self
            } else if textInput .isKindOfClass(UITextField) {
                (textInput as UITextField).inputView = self
            }
        }
    }
    
//    override func layoutSublayersOfLayer(layer: CALayer!) {
//        (layer.superlayer.sublayers[0] as CALayer).opacity = 0.0
//    }
    
    //MARK: Helpers
    class func loadFromNibNamed(nibNamed: String, bundle : NSBundle = NSBundle.mainBundle()) -> ETCustomKeyboard! {
        return UINib(nibName: nibNamed, bundle: bundle).instantiateWithOwner(nil, options: nil)[0] as? ETCustomKeyboard
    }
    
    class func loadKeyboard(textInput:UITextInput) -> ETCustomKeyboard {
        var view:ETCustomKeyboard = UINib(nibName: "ETCustomKeyboard", bundle: NSBundle.mainBundle()).instantiateWithOwner(nil, options: nil)[0] as ETCustomKeyboard
        view.textInput = textInput
        return view
    }
    
    func length()->Int {
        return countElements((textInput as UITextField).text!)
    }
    
    //MARK: IBActions
    
    @IBAction func characterPressed(sender: AnyObject) {
        UIDevice.currentDevice().playInputClick()
        var button = sender as UIButton
        
        if textInput .isKindOfClass(UITextView) {
            textInput.insertText(button.currentTitle!)
            NSNotificationCenter.defaultCenter().postNotificationName(UITextViewTextDidChangeNotification, object: nil)
        } else if textInput .isKindOfClass(UITextField) {
            if (((textInput as UITextField).delegate?.respondsToSelector(Selector("textField:shouldChangeCharactersInRange:replacementString:")))!) {
                var shouldChange:Bool? = (textInput as UITextField).delegate?.textField!(textInput as UITextField, shouldChangeCharactersInRange: NSMakeRange(self.length(), 0), replacementString: button.currentTitle!)
                if shouldChange! {
                    textInput.insertText(button.currentTitle!)
                    NSNotificationCenter.defaultCenter().postNotificationName(UITextFieldTextDidChangeNotification, object: nil)
                }
            } else {
                textInput.insertText(button.currentTitle!)
            }
        }
    }
    
    @IBAction func returnPressed(sender: AnyObject) {
        UIDevice.currentDevice().playInputClick()
        
        if textInput .isKindOfClass(UITextView) {
            textInput.insertText("\n")
            NSNotificationCenter.defaultCenter().postNotificationName(UITextViewTextDidChangeNotification, object: self.textInput)
        } else if textInput .isKindOfClass(UITextField) {
            if (((textInput as UITextField).delegate?.respondsToSelector(Selector("textFieldShouldReturn:"))))! {
                (textInput as UITextField).delegate?.textFieldShouldReturn!(textInput as UITextField)
            }
        }
    }
    
    @IBAction func deletePressed(sender: AnyObject) {
        UIDevice.currentDevice().playInputClick()
        NSNotificationCenter.defaultCenter().postNotificationName(UITextViewTextDidBeginEditingNotification, object: self.textInput)
        
        if textInput.isKindOfClass(UITextView) {
            self.textInput.deleteBackward()
            
        } else if textInput .isKindOfClass(UITextField) {
            if (((textInput as UITextField).delegate?.respondsToSelector(Selector("textField:shouldChangeCharactersInRange:replacementString:")))!) {
                var shouldChange:Bool? = (textInput as UITextField).delegate?.textField!(textInput as UITextField, shouldChangeCharactersInRange: NSMakeRange(0, 0), replacementString: "")
                if shouldChange! {
                    self.textInput.deleteBackward()
                    NSNotificationCenter.defaultCenter().postNotificationName(UITextFieldTextDidChangeNotification, object: nil)
                }
            } else {
                self.textInput.deleteBackward()
                NSNotificationCenter.defaultCenter().postNotificationName(UITextFieldTextDidChangeNotification, object: nil)
            }
        }
    }
    
    @IBAction func hidePressed(sender: AnyObject) {
        if textInput.isKindOfClass(UITextView) {
            (textInput as UITextView).resignFirstResponder()
        } else if textInput .isKindOfClass(UITextField) {
            (textInput as UITextField).resignFirstResponder()
        }
    }
    
}
