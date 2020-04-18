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
    
    private init() {
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
    
    func getUserTickets(seller: User, callback: @escaping ([Ticket])->Void){
        self.getAll { (allTickets) in
            callback(allTickets.filter { (currentTicket) -> Bool in
                return currentTicket.seller.id == seller.id
            });
        }
    }
    
    func update(element: Ticket, callback: @escaping ()->Void){
        remoteDBAccessor.update(element: element) { () in
            callback()
        }
        
        // deleting the pre updated ticket on localdb
        localDBAccessor.delete(element: element)
        ModelEvents.TicketUpdatedDataEvent.post()
    }
    
    func delete(element: Ticket, callback: @escaping ()->Void){
        remoteDBAccessor.delete(element: element) {
            callback()
        }
        
        localDBAccessor.delete(element: element)
        ModelEvents.TicketDeletedDataEvent.post()
    }
    
    func add(element:Ticket) {
        remoteDBAccessor.add(element: element);
        ModelEvents.TicketAddedDataEvent.post();
    }
    
    func saveImage(image:UIImage, callback: @escaping (String)->Void){
        FirebaseStorageService.saveImage(image: image, callback: callback)
    }
}
