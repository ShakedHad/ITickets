//
//  RegisterViewController.swift
//  iTickets
//
//  Created by admin on 01/03/2020.
//  Copyright © 2020 ss. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var fullNameTextView: UITextField!
    @IBOutlet weak var phoneTextView: UITextField!
    @IBOutlet weak var emailAddressTextView: UITextField!
    @IBOutlet weak var passwordTextView: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextView.isSecureTextEntry = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func Register(_ sender: Any) {
        UsersStore.instance.register(emailAddress: emailAddressTextView.text!, password: passwordTextView.text!, phone: phoneTextView.text!, fullName: fullNameTextView.text!) {
                self.performSegue(withIdentifier: "registeredSegue", sender: self);
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
