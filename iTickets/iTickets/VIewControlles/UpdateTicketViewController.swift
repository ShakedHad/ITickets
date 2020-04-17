//
//  UpdateTicketViewController.swift
//  iTickets
//
//  Created by tal avraham on 11/03/2020.
//  Copyright © 2020 ss. All rights reserved.
//

import UIKit

class UpdateTicketViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var artistTextView: UITextField!
    @IBOutlet weak var priceTextView: UITextField!
    @IBOutlet weak var locationTextView: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var updateImageButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var updateButton: UIButton!
    var ticket : Ticket?
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        artistTextView.text = ticket!.artist
        priceTextView.text = String(ticket!.price)
        locationTextView.text = ticket!.location
        datePicker.date = ticket!.time
        
        if(ticket?.image != ""){
            image.kf.setImage(with: URL(string: ticket!.image))
        }
    }
    
    @IBAction func updateTicket(_ sender: Any) {
        performTicketStoreAction(){
        if let image = selectedImage{
            let formatter = DateFormatter();
            formatter.dateFormat = "dd/MM/yyyy, HH:mm";
            let ticketDate = datePicker.date
            
        TicketsStore.instance.saveImage(image: image) { (url) in
                print("saved image url \(url)");
                
            let seller = User(name: "Shir", phone: "0546774799", id: "315005660", emailAddress: "")
                
                let ticket = Ticket(artist: self.artistTextView.text!, price: Int(self.priceTextView.text!)!, time: ticketDate, location: self.locationTextView.text!, image: url, seller: seller)
            
                TicketsStore.instance.update(element: ticket)
                }
            }
        }
    }
    
    @IBAction func deleteTicket(_ sender: Any) {
        performTicketStoreAction(){
    TicketsStore.instance.delete(element: ticket!)
        }
    }
    
    func performTicketStoreAction(callback: ()-> Void){
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        updateButton.isEnabled = false
        deleteButton.isEnabled = false
        updateImageButton.isEnabled = false
        
        callback()
        
        self.navigationController?.popViewController(animated: true);
        
    }
    
    @IBAction func updateImage(_ sender: Any) {
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
