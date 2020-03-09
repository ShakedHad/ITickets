//
//  User.swift
//  iTickets
//
//  Created by admin on 02/03/2020.
//  Copyright © 2020 ss. All rights reserved.
//

import Foundation

class User : Encodable, Decodable {
    var name:String;
    var phone:String;
    var id:String;
    var emailAddress:String;
    
    init(name:String, phone:String, id:String, emailAddress:String) {
        self.name = name;
        self.phone = phone;
        self.id = id;
        self.emailAddress = emailAddress;
    }
}
