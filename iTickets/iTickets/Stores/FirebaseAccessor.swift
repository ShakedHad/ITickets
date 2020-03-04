//
//  FirebaseAccessor.swift
//  iTickets
//
//  Created by admin on 03/03/2020.
//  Copyright © 2020 ss. All rights reserved.
//

import Foundation
import Firebase

class FirebaseAccessor: AsyncStoreProtocol {
    
    var db = Firestore.firestore();
    
    
    func getAll(callback: @escaping (([Ticket])->Void)) {
//        db.collection("tickets").whereField("updateTime", isGreaterThan: Timestamp(seconds: since, nanoseconds: 0)).getDocuments() { (querySnapshot, err) in
        db.collection("tickets").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
//                let students = querySnapshot!.documents.map { (QueryDocumentSnapshot) -> Student in
//                    let document:[String:Any] = QueryDocumentSnapshot.data() ;
//                    return Student(_name: document["name"]! as! String, _id: document["id"]! as! String, _avatar: document["avatar"]! as! String);
//                }
//                callback(students);
            }
        }
//        return [Ticket]();
    }
    
    func add(element: Ticket) {
        
    }
}
