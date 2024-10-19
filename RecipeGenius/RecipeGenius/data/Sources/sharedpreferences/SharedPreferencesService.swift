//
//  SharedPreferencesServiceImpl.swift
//  data
//
//  Created by Daria Nikitina on 08.10.2024.
//

import Foundation

public protocol SharedPreferencesService: AnyObject {
    func saveUser(_ user: User) -> Bool
    func getUser() -> User
    
    var isLogin: Bool { get set }
}
