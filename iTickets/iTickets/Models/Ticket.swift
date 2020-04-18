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
    var id:String = "";
    var artist:String;
    var price:Int;
    var time:Date;
    var location:String;
    var image:String;
    var seller:User;
    var updateTime:Date = Date();

    
    init(id: String, artist:String, price:Int, time:Date, location:String, image:String, seller:User) {
        self.id = id;
        self.artist = artist;
        self.price = price;
        self.time = time;
        self.location = location;
        self.image = image;
        self.seller = seller;
    }
}

class ModelEvents {
    static let TicketAddedDataEvent = EventNotificationBase(eventName: "com.shir.TicketAddedDataEvent")
    static let LoggingStateChangedEvent = EventNotificationBase(eventName:"com.shir.LoggingStateChangeEvent")
    static let TicketUpdatedDataEvent = EventNotificationBase(eventName:"com.shir.TicketUpdatedDataEvent")
    static let TicketDeletedDataEvent = EventNotificationBase(eventName:"com.shir.TicketDeletedDataEvent")
    
    private init(){}
}

class EventNotificationBase{
    let eventName : String
    
    init(eventName:String){
        self.eventName = eventName
    }
    
    func observe(callback:@escaping ()->Void){
        NotificationCenter.default.addObserver(forName: NSNotification.Name(eventName), object: nil, queue: nil){ (data) in
            callback()
        }
    }
    
    func post(){
        NotificationCenter.default.post(name: NSNotification.Name(eventName), object: self, userInfo: nil)
    }
}

