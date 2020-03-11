//
//  MyTicketsTableViewCell.swift
//  iTickets
//
//  Created by tal avraham on 10/03/2020.
//  Copyright © 2020 ss. All rights reserved.
//

import UIKit

class MyTicketsTableViewCell: UITableViewCell {
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var postImageImageVIew: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func deleteTicket(_ sender: Any) {
    }
    @IBAction func editTicket(_ sender: Any) {
    }
}
