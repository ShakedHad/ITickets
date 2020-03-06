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
                    var data = QueryDocumentSnapshot.data()
                    data["time"] = (data["time"] as! Timestamp).dateValue();
                    
                    data["id"] = QueryDocumentSnapshot.documentID;
                    
                    let decoder = FirestoreDecoder();
                    let ticket = try! decoder.decode(Ticket.self, from: data)
                    return ticket;
                }
                callback(tickets);
            }
        }
    }

    
    func add(element: Ticket) {
        var ref: DocumentReference? = nil

        let ticketJson = try! FirestoreEncoder().encode(element)
        
        ref = db.collection("tickets").addDocument(data: ticketJson) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
    }
}
