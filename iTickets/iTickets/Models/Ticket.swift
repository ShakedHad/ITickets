//
//  Ticket.swift
//  iTickets
//
//  Created by admin on 02/03/2020.
//  Copyright © 2020 ss. All rights reserved.
//

import Foundation
import UIKit
import CodableFirebase
import Firebase

extension Timestamp: TimestampType {};

class Ticket : Encodable, Decodable {
    var artist:String;
    var price:Int;
    var time:Timestamp;
    var location:String;
    var image:String;
    var seller:User;

    
    init(artist:String, price:Int, time:Timestamp, location:String, image:String, seller:User) {
        self.artist = artist;
        self.price = price;
        self.time = time;
        self.location = location;
        self.image = image;
        self.seller = seller;
    }
}
