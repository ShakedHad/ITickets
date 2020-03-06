//
//  SyncStoreProtocol.swift
//  iTickets
//
//  Created by admin on 03/03/2020.
//  Copyright © 2020 ss. All rights reserved.
//

import Foundation

protocol SyncStoreProtocol {
    associatedtype storeType;
    func getAll()->[storeType];
    func add(element:storeType);
}
