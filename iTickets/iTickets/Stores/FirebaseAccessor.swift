//
//  FirebaseAccessor.swift
//  iTickets
//
//  Created by admin on 03/03/2020.
//  Copyright © 2020 ss. All rights reserved.
//

import Foundation
import Firebase
import CodableFirebase

class FirebaseAccessor: AsyncStoreProtocol {
    
    var db = Firestore.firestore();
    
    
    func getAll(callback: @escaping (([Ticket])->Void)) {
        //        db.collection("tickets").whereField("updateTime", isGreaterThan: Timestamp(seconds: since, nanoseconds: 0)).getDocuments() { (querySnapshot, err) in
        db.collection("tickets").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                let tickets = querySnapshot!.documents.map { (QueryDocumentSnapshot) -> Ticket in
                    
                    
//                    var data = QueryDocumentSnapshot.data()
//                    data["time"] = (data["time"] as! Timestamp).dateValue();
                    let decoder = FirestoreDecoder();

//                    decoder.dateDecodingStrategy = .custom { decoder -> Date in
//                        let container = try decoder.singleValueContainer()
//                        let timestamp = try container.decode(Timestamp.self)
//
//                        return timestamp.dateValue()
//                    }
                    
//                    let ticket = try! decoder.decode(Ticket.self, from: data)
                    let ticket = try! decoder.decode(Ticket.self, from: QueryDocumentSnapshot.data())
                    return ticket;
                }
                callback(tickets);
//                                callback([Ticket]());
            }
        }
    }
    
    
    //                    guard let value = QueryDocumentSnapshot.value else { return }
    //                    do {
    //                        let ticket = try FirebaseDecoder().decode(Ticket.self, from: value)
    //                        return ticket
    //                    } catch let error {
    //                        print(error)
    //                    }
    //                    let document:[String:Any] = QueryDocumentSnapshot.data() ;
    ////                    let encoder = JSONEncoder();
    ////                    encoder.encode(document);
    //                    let decoder = JSONDecoder();
    //                    let currentTicket = try decoder.decode(Ticket.self, from: document)
    //                    return Student(_name: document["name"]! as! String, _id: document["id"]! as! String, _avatar: document["avatar"]! as! String);
    //                    return currentTicket;

    
    func add(element: Ticket) {
        var ref: DocumentReference? = nil
        
        var ticket = Ticket(artist: "Tuna", price: 250, time: Timestamp(date: Date()), location: "Park Hayarkon", image: "", seller: User(name: "Shaked Hadas", phone: "0524481484", id: "313161200"));
        

        let ticketJson = try! FirestoreEncoder().encode(ticket)
        
        ref = db.collection("tickets").addDocument(data: ticketJson) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
    }
}
