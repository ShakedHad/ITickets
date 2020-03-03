//
//  TicketInfoViewController.swift
//  iTickets
//
//  Created by admin on 02/03/2020.
//  Copyright © 2020 ss. All rights reserved.
//

import UIKit

class TicketInfoViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var sellerNameLabel: UILabel!
    @IBOutlet weak var sellerPhoneLabel: UILabel!
    
    var ticket:Ticket?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.artistLabel.text = ticket!.artist;
        self.locationLabel.text = ticket!.location;
        
        let formatter = DateFormatter();
        formatter.dateFormat = "dd/MM/yyyy, HH:mm";
        self.timeLabel.text = formatter.string(from: ticket!.time);
        self.sellerNameLabel.text = ticket!.seller.name;
        self.sellerPhoneLabel.text = ticket!.seller.phone;
        self.priceLabel.text = String(ticket!.price)+"₪";
//        self.imageView.image = ticket.image;
        self.imageView.image = UIImage(named: "emptyArtist");
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
