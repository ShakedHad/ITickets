//
//  StoreProtocol.swift
//  iTickets
//
//  Created by admin on 03/03/2020.
//  Copyright © 2020 ss. All rights reserved.
//

import Foundation

protocol AsyncStoreProtocol {
    associatedtype storeType;
    func getAll(callback: @escaping (([storeType])->Void));
    func add(element:storeType);
}
