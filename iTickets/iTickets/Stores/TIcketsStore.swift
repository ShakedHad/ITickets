//
//  TIcketsStore.swift
//  iTickets
//
//  Created by admin on 02/03/2020.
//  Copyright © 2020 ss. All rights reserved.
//
    
import Foundation
import UIKit

class TicketsStore : AsyncStoreProtocol {
        
    static let instance:TicketsStore = TicketsStore();
    var data:[Ticket] = [Ticket]();
    
    private init() {
        for _ in 0...10 {
            add(element: Ticket(artist: "Ravid Plotnik", price: 250, time: Date(), location: "Park hayarkon", image: UIImage(), seller: User(name: "Shaked Hadas", phone: "0524481484", id: "313161200")));
        }
        
        print("bla");
        
    }
    
    func getAll(callback: @escaping ([Ticket])->Void){
//        return data;
    }
    
    func add(element:Ticket) {
        data.append(element);
    }
}
