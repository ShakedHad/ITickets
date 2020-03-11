//
//  UpdateTicketViewController.swift
//  iTickets
//
//  Created by tal avraham on 11/03/2020.
//  Copyright © 2020 ss. All rights reserved.
//

import UIKit

class UpdateTicketViewController: UIViewController {

    @IBOutlet weak var artistTextView: UITextField!
    @IBOutlet weak var priceTextView: UITextField!
    @IBOutlet weak var locationTextView: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var ticket : Ticket?
    
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
        
    }
    
    
    @IBAction func updateImage(_ sender: Any) {
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
