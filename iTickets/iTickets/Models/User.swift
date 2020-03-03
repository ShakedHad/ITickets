//
//  User.swift
//  iTickets
//
//  Created by admin on 02/03/2020.
//  Copyright © 2020 ss. All rights reserved.
//

import Foundation

class User {
    var name:String;
    var phone:String;
    var id:String;
    
    init(name:String, phone:String, id:String) {
        self.name = name;
        self.phone = phone;
        self.id = id;
    }
}
