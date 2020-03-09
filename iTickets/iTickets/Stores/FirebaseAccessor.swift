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
                callback((lastUpdatedTicket["updateTime"] as! Timestamp).dateValue());
            }
        };
    }
    
    func login(emailAddress:String, password:String, callback:()->Void) {
        Auth.auth().signIn(withEmail: emailAddress, password: password) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
          // ...
        }
    }
    
    func register(emailAddress:String, password:String, phone:String, fullName:String, callback:()->Void) {
        Auth.auth().createUser(withEmail: emailAddress, password: password) { authResult, error in
            if (error != nil) {
//                authResult?.additionalUserInfo
                // Add User to users collection
                self.add(element: User(name: fullName, phone: phone, id: authResult?.additionalUserInfo., emailAddress: emailAddress))
            }
        }
    }
    
    func add(element:User) {
        var ref: DocumentReference? = nil
        let userJson = try! FirestoreEncoder().encode(element)
        
        ref = db.collection("users").addDocument(data: userJson) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
}
