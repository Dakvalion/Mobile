//
//  SharedPreferencesServiceImpl.swift
//  data
//
//  Created by Daria Nikitina on 08.10.2024.
//

import Foundation

public class SharedPreferencesServiceImpl: SharedPreferencesService {
    private let sharedPreferences = UserDefaults.standard
    private let keyId = "user_id"
    private let keyName = "user_name"
    private let keyEmail = "user_email"
    private let keyIsLogin = "user_is_login"
    
    public init() {}
    
    public func getUser() -> User {
        let uid = sharedPreferences.string(forKey: keyId) ?? ""
        let name = sharedPreferences.string(forKey: keyName) ?? ""
        let email = sharedPreferences.string(forKey: keyEmail) ?? ""
        return User(uid: uid, name: name, email: email)
    }
    
    public func saveUser(_ user: User) -> Bool {
        sharedPreferences.set(user.uid, forKey: keyId)
        sharedPreferences.set(user.name, forKey: keyName)
        sharedPreferences.set(user.email, forKey: keyEmail)
        return true
    }
    
    public var isLogin: Bool {
        get { sharedPreferences.bool(forKey: keyIsLogin)}
        set { sharedPreferences.set(newValue, forKey: keyIsLogin) }
    }
}
