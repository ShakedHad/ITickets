//
//  LoginViewController.swift
//  iTickets
//
//  Created by admin on 01/03/2020.
//  Copyright © 2020 ss. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var EmailAddressTextView: UITextField!
    @IBOutlet weak var PasswordTextView: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        PasswordTextView.isSecureTextEntry = true
        // Do any additional setup after loading the view.
    }
    

    @IBAction func Login(_ sender: Any) {
        UsersStore.instance.login(emailAddress: EmailAddressTextView!.text!, password: PasswordTextView!.text!) {
            
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
