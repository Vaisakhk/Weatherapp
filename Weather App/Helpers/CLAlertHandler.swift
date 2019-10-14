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
    
}
