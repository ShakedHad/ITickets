//
//  AddTicketViewController.swift
//  iTickets
//
//  Created by tal avraham on 09/03/2020.
//  Copyright © 2020 ss. All rights reserved.
//

import UIKit

class AddTicketViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, authenticationDelegate {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var artistTextView: UITextField!
    @IBOutlet weak var priceTextView: UITextField!
    @IBOutlet weak var locationTextView: UITextField!
    @IBOutlet weak var addTicketButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
        var selectedImage: UIImage?
    override func viewDidLoad() {
        activityIndicator.isHidden = true
        
        if !UsersStore.instance.doesUserLogged() {
            LoginViewController.show(sender: self);
        }
        
        super.viewDidLoad()
    }
    
    @IBAction func addTicket(_ sender: Any) {
        if let image = selectedImage{
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()

            addTicketButton.isEnabled = false
            addImageButton.isEnabled = false

            let formatter = DateFormatter();
            formatter.dateFormat = "dd/MM/yyyy, HH:mm";
            let ticketDate = datePicker.date
            
        TicketsStore.instance.saveImage(image: image) { (url) in
                print("saved image url \(url)");
                
            UsersStore.instance.getLoggedUser { (currentUser) in
                    let ticket = Ticket(artist: self.artistTextView.text!, price: Int(self.priceTextView.text!)!, time: ticketDate, location: self.locationTextView.text!, image: url, seller: currentUser)
                    TicketsStore.instance.add(element: ticket)
                            self.navigationController?.popViewController(animated: true);
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
    
    func onLoginSuccess() {
        print("Successfull login");
    }
    
    func onLoginFailed() {
        self.navigationController?.popViewController(animated: false);
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
