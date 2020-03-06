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
    var id:String;
    var artist:String;
    var price:Int;
    var time:Date;
    var location:String;
    var image:String;
    var seller:User;

    
    init(id:String,artist:String, price:Int, time:Date, location:String, image:String, seller:User) {
        self.id = id;
        self.artist = artist;
        self.price = price;
        self.time = time;
        self.location = location;
        self.image = image;
        self.seller = seller;
    }
}
