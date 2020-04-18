//
//  RegisterViewController.swift
//  iTickets
//
//  Created by admin on 01/03/2020.
//  Copyright © 2020 ss. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var fullNameTextView: UITextField!
    @IBOutlet weak var phoneTextView: UITextField!
    @IBOutlet weak var emailAddressTextView: UITextField!
    @IBOutlet weak var passwordTextView: UITextField!
    
@IBOutlet weak var image: UIImageView!
    @IBOutlet weak var addImageButton: UIButton!
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loader.isHidden = true
        passwordTextView.isSecureTextEntry = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func Register(_ sender: Any) {
        loader.isHidden = false
        loader.startAnimating()
        
        
        if let image = self.selectedImage {
            UsersStore.instance.saveAvatar(image: image) { (url) in
                print("saved image url \(url)");
                
//                self.navigationController?.popViewController(animated: true);
                UsersStore.instance.register(emailAddress: self.emailAddressTextView.text!, password: self.passwordTextView.text!, phone: self.phoneTextView.text!, fullName: self.fullNameTextView.text!, avatarUrl: url) {
                        print("user added");
                        self.performSegue(withIdentifier: "registeredSegue", sender: self);
                }
            }
        }
    }
    
    @IBAction func addImage(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerController.SourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePicker.sourceType =
                UIImagePickerController.SourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        self.image.image = selectedImage
        dismiss(animated: true, completion: nil)
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
