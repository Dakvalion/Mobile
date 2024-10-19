//
//  User.swift
//
//
//  Created by Daria Nikitina on 11.10.2024.
//

import Foundation

public class User {
    public let uid: String
    public let name: String
    public let email: String
    
    public init(uid: String, name: String, email: String) {
        self.uid = uid
        self.name = name
        self.email = email
    }
}
