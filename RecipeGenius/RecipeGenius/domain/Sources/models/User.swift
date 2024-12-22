//
//  User.swift
//  RecipeGenius
//
//  Created by Daria Nikitina on 11.10.2024.
//

import Foundation

public class User: Identifiable {
    public let uid: String
    public let email: String
    
    public init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
}
