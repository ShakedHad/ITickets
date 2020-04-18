//
//  UsersStrore.swift
//  iTickets
//
//  Created by admin on 09/03/2020.
//  Copyright © 2020 ss. All rights reserved.
//

import Foundation
import UIKit

class UsersStore {
    var firebaseAccessor:FirebaseAccessor = FirebaseAccessor();
    static let instance:UsersStore = UsersStore();
    
    private init() {
    }
    
    func login(emailAddress:String, password:String, callback: @escaping (Bool)->Void) {
        firebaseAccessor.login(emailAddress: emailAddress, password: password, callback: callback);
    }
    
    func logout() {
        firebaseAccessor.logout();
    }
    
    func register(emailAddress:String, password:String, phone:String, fullName:String, avatarUrl:String, callback: @escaping ()->Void) {
        firebaseAccessor.register(emailAddress: emailAddress, password: password,phone: phone, fullName: fullName, avatarUrl:avatarUrl, callback: callback);
    }
    
    func add(element:User) {
        firebaseAccessor.add(element: element);
    }
    
    func getLoggedUser(callback:@escaping (User)->Void) {
        firebaseAccessor.getLoggedUser(callback: callback);
    }
    
    func doesUserLogged() -> Bool {
        firebaseAccessor.doesUserLogged();
    }
    
    func saveAvatar(image:UIImage, callback: @escaping (String)->Void){
        FirebaseStorageService.saveImage(image: image, callback: callback)
    }
}
