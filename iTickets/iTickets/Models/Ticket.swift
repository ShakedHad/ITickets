//
//  Ticket.swift
//  iTickets
//
//  Created by admin on 02/03/2020.
//  Copyright © 2020 ss. All rights reserved.
//

import Foundation
import UIKit

class Ticket {
    var artist:String;
    var price:Int;
    var time:Date;
    var location:String;
    var image:UIImage;
    var seller:User;
    
    init(artist:String, price:Int, time:Date, location:String, image:UIImage, seller:User) {
        self.artist = artist;
        self.price = price;
        self.time = time;
        self.location = location;
        self.image = image;
        self.seller = seller;
    }
}
