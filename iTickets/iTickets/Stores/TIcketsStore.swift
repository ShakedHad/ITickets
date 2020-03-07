//
//  TIcketsStore.swift
//  iTickets
//
//  Created by admin on 02/03/2020.
//  Copyright © 2020 ss. All rights reserved.
//
    
import Foundation
import UIKit
import Firebase

class TicketsStore : AsyncStoreProtocol {
        
    static let instance:TicketsStore = TicketsStore();
    var remoteDBAccessor:FirebaseAccessor = FirebaseAccessor();
    var localDBAccessor:SqliteAccesoor = SqliteAccesoor();
    var data:[Ticket] = [Ticket]();
    
    private init() {
//        for _ in 0...10 {
//        remoteDBAccessor.add(element: Ticket(id:"123",artist: "Ravid Plotnik2", price: 250, time: Date(), location: "Park hayarkon", image: "", seller: User(name: "Shaked Hadas", phone: "0524481484", id: "313161200")));
//        }
////
//        print("bla");
//        var bla = localDBAccessor.getAll();
//        localDBAccessor.setLastUpdatedDate(tableName: "tickets", lastUpdatedDate: Date());
//        var date = localDBAccessor.getLastUpdatedDate(tableName: "tickets");
//        print (date);
    }
    
    func getAll(callback: @escaping ([Ticket])->Void){
        let cacheLastUpdatedDate = localDBAccessor.getLastUpdatedDate(tableName: "tickets");
        remoteDBAccessor.getAll(since: cacheLastUpdatedDate) { newTickets in
            for ticket in newTickets {
                self.localDBAccessor.add(element: ticket);
            }
            
            self.remoteDBAccessor.getServerLastUpdatedDate() { serverLastUpdatedDate in
                self.localDBAccessor.setLastUpdatedDate(tableName: "tickets", lastUpdatedDate: serverLastUpdatedDate);
                let allTickets = self.localDBAccessor.getAll();
                
                callback(allTickets)
            };
            
        };
    }
    
    func add(element:Ticket) {
        remoteDBAccessor.add(element: element);
    }
}
