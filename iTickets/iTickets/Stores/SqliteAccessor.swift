//
//  SqliteAccessor.swift
//  iTickets
//
//  Created by admin on 03/03/2020.
//  Copyright © 2020 ss. All rights reserved.
//

import Foundation
import SQLite

class SqliteAccesoor: SyncStoreProtocol {
    
    var db:Connection?;
    let usersTable = Table("users");
    let userId = Expression<String>("userId");
    let name = Expression<String>("name");
    let phone = Expression<String>("phone");
    
    let ticketsTable = Table("tickets");
    let ticketId = Expression<String>("ticketId");
    let artist = Expression<String>("artist");
    let price = Expression<Int>("price");
    let time = Expression<Date>("time")
    let location = Expression<String>("location")
    let image = Expression<String>("image")
    let sellerID = Expression<String>("sellerID")
    
    let lastUpdatedDateTable = Table("lastUpdatedDate");
    let tableNameColumn = Expression<String>("tableName");
    let lastUpdatedDateColumn = Expression<Date>("lastUpdatedDate");
    
    init() {
        do {
            let dbFileName = "iTickets.db";
            
            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
                let path = dir.appendingPathComponent(dbFileName);
                
                db = try Connection(path.absoluteString);
                
                createTables()
            }
        } catch let err {
            print("Error while connecting to databse: \(err)")
            db = nil;
        }
    }
    
    fileprivate func createTables() {
        do {
            try db?.run(usersTable.create(ifNotExists: true) { t in
                t.column(userId, primaryKey: true)
                t.column(name)
                t.column(phone)
            });
            
            try db?.run(ticketsTable.create(ifNotExists: true) { t in
                t.column(ticketId, primaryKey: true)
                t.column(artist)
                t.column(price)
                t.column(time)
                t.column(location)
                t.column(image)
                t.column(sellerID)
                t.foreignKey(sellerID, references: usersTable, userId, delete: .setNull)
            });
            
            try db?.run(lastUpdatedDateTable.create(ifNotExists: true) { t in
                t.column(tableNameColumn, primaryKey: true)
                t.column(lastUpdatedDateColumn)
            });
            
        } catch let err {
            print("Error while creating tables: \(err)")
        }
    }
    
    func getAll() -> [Ticket] {
        do {
            let tickets = (try (db?.prepare(ticketsTable.join(usersTable, on: userId == sellerID)))!).map { (ticketRow) -> Ticket in

                return Ticket(id:ticketRow[ticketId], artist: ticketRow[artist],
                      price: ticketRow[price],
                      time: ticketRow[time],
                  location: ticketRow[location],
                  image: ticketRow[image],
                  seller: User(name: ticketRow[name], phone: ticketRow[phone], id: ticketRow[userId], emailAddress: ""))
            }
            
            return tickets;
        } catch let err {
            print("Error while getting tickets: \(err)")
            return [Ticket]()
        }
    }
    
    func add(element: Ticket) {
        do {
            try db?.run(usersTable.insert(or: .replace,
                                            userId <- element.seller.id,
                                            name <- element.seller.name,
                                            phone <- element.seller.phone));
            
            try db?.run(ticketsTable.insert(or: .replace,
                                       ticketId <- element.id,
                                       artist <- element.artist,
                                       price <- element.price,
                                       time <- element.time,
                                       location <- element.location,
                                       image <- element.image,
                                       sellerID <- element.seller.id));
        } catch let err {
            print("Error while adding ticket: \(err)")
        }
    }
    
    func getLastUpdatedDate(tableName:String)->Date {
        do {
            let date = (try (db?.prepare(lastUpdatedDateTable.filter(tableNameColumn == tableName)))!).first(where: {row in true});
            
            return date?[lastUpdatedDateColumn] ?? Date(timeIntervalSince1970: 0);
        } catch let err {
            print("Error while getting tickets: \(err)")
            return Date();
        }
    }
    
    func setLastUpdatedDate(tableName:String, lastUpdatedDate: Date) {
        do {
            try db?.run(lastUpdatedDateTable.insert(or: .replace,
                                                    tableNameColumn <- tableName,
                                                    lastUpdatedDateColumn <- lastUpdatedDate));
        } catch let err {
            print("Error while setting updated date ticket: \(err)")
        }
    }
}
