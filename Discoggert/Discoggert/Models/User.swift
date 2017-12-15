//
//  User.swift
//  Discoggert
//
//  Created by Timo den Hartog on 08-12-17.
//  Copyright © 2017 Timo den Hartog. All rights reserved.
//

import Foundation

struct User {
    
    let uid: String
    let email: String
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
    
}
