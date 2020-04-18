//
//  LoginViewController.swift
//  iTickets
//
//  Created by admin on 01/03/2020.
//  Copyright © 2020 ss. All rights reserved.
//

import UIKit

protocol authenticationDelegate {
    func onLoginSuccess();
    func onLoginFailed();
}

class LoginViewController: UIViewController {
    var sender:authenticationDelegate?;
    @IBOutlet weak var EmailAddressTextView: UITextField!
    @IBOutlet weak var PasswordTextView: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        PasswordTextView.isSecureTextEntry = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelLogin(sender:)));
    }
    
    static func show(sender:authenticationDelegate?) {
        let viewController:LoginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LoginViewController");
        viewController.sender = sender;
        (sender as! UIViewController).show(viewController, sender: sender as! UIViewController);
    }

    @IBAction func Login(_ sender: Any) {
        UsersStore.instance.login(emailAddress: EmailAddressTextView!.text!, password: PasswordTextView!.text!) {
            print("logged in");

            self.navigationController?.popViewController(animated: true);
            if let sender = self.sender{
                sender.onLoginSuccess()
            }
        }
    }
    
    @objc func cancelLogin(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true);
        if let sender = self.sender{
            sender.onLoginFailed();
        }
    }
    
    @IBAction func unwindFromRegister(segue: UIStoryboardSegue) {
        print("unwinded")
        self.navigationController?.popViewController(animated: true);
        self.navigationController?.popViewController(animated: true);
        if let sender = self.sender{
            sender.onLoginSuccess()
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
