//
//  CLAlertHandler.swift
//  SampleToolKitSwift
//
//  Created by Apple on 18/05/17.
//  Copyright © 2017 CL. All rights reserved.
//

import UIKit

let ALERTOKTITLE = "Ok";

@objc public class CLAlertHandler: NSObject {
    @objc static let sharedHandlerInsatnce = CLAlertHandler()
    // MARK: Local Variable
    final class sharedInstance {
        private init() { }
        static let shared = CLAlertHandler()
    }

   @objc public func showAlert(alertMessage:String,title:String,contoller:UIViewController,successBlock: @escaping (_ isSuccess:Bool) -> Void) {
        let alert = UIAlertController(title: title , message: alertMessage , preferredStyle: .alert)
        let ok  = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            successBlock(true)
        }
        alert.addAction(ok)
        contoller.present(alert, animated: true, completion: nil);
    }
    

   @objc public func showAlertWithButtons(alertMessage:String,title:String,successButtonTitle:String,cancelButtonTitle:String,contoller:UIViewController,successBlock: @escaping (_ isSuccess:Bool) -> Void) {
        let alert = UIAlertController(title: title , message: alertMessage , preferredStyle: .alert)
        let ok  = UIAlertAction(title: successButtonTitle, style: .default) { (UIAlertAction) in
            successBlock(true)
        }
        alert.addAction(ok)
        let cancel  = UIAlertAction(title: cancelButtonTitle, style: .default) { (UIAlertAction) in
            successBlock(false)
        }
        alert.addAction(cancel)
        contoller.present(alert, animated: true, completion: nil);
    }
    
   @objc public func showAlertWithThreeButtons(alertMessage:String,title:String,firstButtonTitle:String,secondButtonTitle:String,thirdButtonTitle:String,contoller:UIViewController,successBlock: @escaping (_ successTitle:String) -> Void) {
        let alert = UIAlertController(title: title , message: alertMessage , preferredStyle: .alert)
        let ok  = UIAlertAction(title: firstButtonTitle, style: .default) { (UIAlertAction) in
            successBlock(firstButtonTitle)
        }
        alert.addAction(ok)
        let cancel  = UIAlertAction(title: secondButtonTitle, style: .default) { (UIAlertAction) in
            successBlock(secondButtonTitle)
        }
        alert.addAction(cancel)
        let third  = UIAlertAction(title: thirdButtonTitle, style: .default) { (UIAlertAction) in
            successBlock(thirdButtonTitle)
        }
        alert.addAction(third)
        contoller.present(alert, animated: true, completion: nil);
    }

   @objc public func showAlertWithMoreButtons(alertMessage:String,title:String,buttonTitles:Array<Any>,contoller:UIViewController,successBlock: @escaping (_ successTitle:String) -> Void) {
        let alert = UIAlertController(title: title , message: alertMessage , preferredStyle: .alert)
        for actionTitle in buttonTitles {
            let alertAction  = UIAlertAction(title: actionTitle as? String, style: .default) { (UIAlertAction) in
                successBlock(actionTitle as! String)
            }
             alert.addAction(alertAction)
        }
       
        contoller.present(alert, animated: true, completion: nil);
    }
    
    @objc public func showTextFieldAlertWithButtons(alertMessage:String,title:String,hintMessage:String,successButtonTitle:String,cancelButtonTitle:String,contoller:UIViewController,successBlock: @escaping (_ isSuccess:Bool,_ enteredText:String) -> Void) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title , message: alertMessage , preferredStyle: .alert)
            let ok  = UIAlertAction(title: successButtonTitle, style: .default) { (UIAlertAction) in
                let textField = alert.textFields![0] as UITextField
                successBlock(true,textField.text!)
            }
            alert.addAction(ok)
            alert.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = hintMessage
                textField.borderStyle = .none
                textField.isEnabled = true
                textField.isSecureTextEntry = false
            }
            let cancel  = UIAlertAction(title: cancelButtonTitle, style: .default) { (UIAlertAction) in
                successBlock(false,"")
            }
            alert.addAction(cancel)
            contoller.present(alert, animated: true, completion: nil);
        }
    }
    
    @objc public func showNonEditableTextFieldAlertWithButtons(alertMessage:String,title:String,hintMessage:String,successButtonTitle:String,cancelButtonTitle:String,contoller:UIViewController,successBlock: @escaping (_ isSuccess:Bool,_ enteredText:String) -> Void) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title , message: alertMessage , preferredStyle: .alert)
            let ok  = UIAlertAction(title: successButtonTitle, style: .default) { (UIAlertAction) in
                let textField = alert.textFields![0] as UITextField
                successBlock(true,textField.text!)
            }
            alert.addAction(ok)
            alert.addTextField { (textField : UITextField!) -> Void in
                textField.text = hintMessage
                textField.borderStyle = .none
                textField.isEnabled = false
                textField.isSecureTextEntry = false
            }
            let cancel  = UIAlertAction(title: cancelButtonTitle, style: .default) { (UIAlertAction) in
                successBlock(false,"")
            }
            alert.addAction(cancel)
            contoller.present(alert, animated: true, completion: nil);
        }
    }
    
}
