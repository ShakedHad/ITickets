//
//  FirebaseStorageService.swift
//  iTickets
//
//  Created by tal avraham on 09/03/2020.
//  Copyright © 2020 ss. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import CommonCrypto

class FirebaseStorageService {
    static func saveImage(image:UIImage, callback:@escaping (String)->Void){
        
    let storageee = Storage.storage()
    let storageRef = storageee.reference(forURL:
        "gs://itickets-b6dd2.appspot.com")
        
    let data = image.jpegData(compressionQuality: 0.8)
    let imageRef = storageRef.child(String(Timestamp.init().nanoseconds))
    let metadata = StorageMetadata()
    metadata.contentType = "image/jpeg"
    imageRef.putData(data!, metadata: metadata) { (metadata, error) in
    imageRef.downloadURL { (url, error) in
    guard let downloadURL = url else {
    // Uh-oh, an error occurred!
    return
    }
    print("url: \(downloadURL)")
    callback(downloadURL.absoluteString)
    }
    }
    }
}
