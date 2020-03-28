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
        db.collection("tickets").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                let tickets = querySnapshot!.documents.map { (QueryDocumentSnapshot) -> Ticket in
                    var data = QueryDocumentSnapshot.data()
                    data["time"] = (data["time"] as! Timestamp).dateValue();
                    data["updateTime"] = (data["updateTime"] as! Timestamp).dateValue();

                    data["id"] = QueryDocumentSnapshot.documentID;

                    let decoder = FirestoreDecoder();
                    let ticket = try! decoder.decode(Ticket.self, from: data)
                    return ticket;
                }
                callback(tickets);
            }
        }
    }
    
    func getAll(since:Date, callback: @escaping (([Ticket])->Void)) {
        db.collection("tickets").whereField("updateTime", isGreaterThan: Timestamp(date: since)).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                let tickets = querySnapshot!.documents.map { (QueryDocumentSnapshot) -> Ticket in
                    var data = QueryDocumentSnapshot.data()
                    data["time"] = (data["time"] as! Timestamp).dateValue();
                    data["updateTime"] = (data["updateTime"] as? Timestamp)?.dateValue() ?? Date(timeIntervalSince1970: 0);

                    data["id"] = QueryDocumentSnapshot.documentID;

                    let decoder = FirestoreDecoder();
                    let ticket = try! decoder.decode(Ticket.self, from: data)
                    return ticket;
                }
                callback(tickets);
            }
        }
    }
    
    func getUserTickets(id:String, since:Date, callback: @escaping (([Ticket])->Void)) {
        db.collection("tickets").whereField("updateTime", isGreaterThan: Timestamp(date: since)).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                let tickets = querySnapshot!.documents.map { (QueryDocumentSnapshot) -> Ticket in
                    var data = QueryDocumentSnapshot.data()
                    data["time"] = (data["time"] as! Timestamp).dateValue();
                    data["updateTime"] = (data["updateTime"] as? Timestamp)?.dateValue() ?? Date(timeIntervalSince1970: 0);

                    data["id"] = QueryDocumentSnapshot.documentID;

                    let decoder = FirestoreDecoder();
                    let ticket = try! decoder.decode(Ticket.self, from: data)
                    return ticket;
                }
                
                callback(tickets);
            }
        }
    }
    
    func delete(element: Ticket){
        // TODO: get real id
        db.collection("tickets").document("5").delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    var serverLastUpdateDate : Date = Date(timeIntervalSince1970: 0)
    
    func update(element: Ticket){

    }

    func add(element: Ticket) {
        var ref: DocumentReference? = nil
        var ticketJson = try! FirestoreEncoder().encode(element)
        
        ticketJson["updateTime"] = FieldValue.serverTimestamp();
        
        ref = db.collection("tickets").addDocument(data: ticketJson) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    func getServerLastUpdatedDate(callback: @escaping (Date)->Void) {
        db.collection("tickets").order(by: "updateTime", descending: true).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                let lastUpdatedTicket:[String:Any] = querySnapshot!.documents[0].data();
                let lastUpdatedTicketTime = (lastUpdatedTicket["updateTime"] as! Timestamp).dateValue()
                callback(lastUpdatedTicketTime);
            }
        };
    }
}
