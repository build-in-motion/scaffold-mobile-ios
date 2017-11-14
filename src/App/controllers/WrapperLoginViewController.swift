//
//  WrapperLoginViewController.swift
//  Wrapper
//
//  Created by Stephen Bechtold on 12/20/16.
//  Copyright © 2016 Build in Motion. All rights reserved.
//

import UIKit
import InMotionUI

public class WrapperLoginViewController: UIViewController  {

 @IBOutlet weak public var errorMessage:UILabel!;
    @IBOutlet weak public var userName: UITextField!
    @IBOutlet weak public var password: UITextField!
    @IBOutlet weak public var loginButton: UIButton!
    @IBOutlet weak public var rememberMe: UISwitch!

    override open func viewDidLoad() {
        super.viewDidLoad()
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction public func loginButtonWasPressed(_ sender: AnyObject) {

    }
}
