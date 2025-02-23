//
//  AuthRepositoryImpl.swift
//  RecipeGenius
//
//  Created by Daria Nikitina on 11.10.2024.
//

import domain

public class AuthRepositoryImpl: AuthRepository {
    private let firebaseService: FirebaseService
    private let sharedPreferences: SharedPreferencesService
    private var result: Result<domain.User, Error>?
    
    public init(firebaseService: FirebaseService, sharedPreferences: SharedPreferencesService) {
        self.firebaseService = firebaseService
        self.sharedPreferences = sharedPreferences
    }
    
    public func signIn(email: String, password: String, completion: @escaping (Result<domain.User, Error>) -> Void) {
        firebaseService.signIn(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                self.setAuthorizationState(user: user)
                completion(.success(self.mapToDomain(user: user)))
            case .failure(let failure):
                self.setNoAuthorizationState()
                completion(.failure(failure))
            }
        }
    }
    
    public func createAccount(email: String, password: String, completion: @escaping (Result<domain.User, Error>) -> Void) {
        firebaseService.createAccount(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                self.setAuthorizationState(user: user)
                completion(.success(self.mapToDomain(user: user)))
            case .failure(let failure):
                self.setNoAuthorizationState()
                completion(.failure(failure))
            }
        }
    }
    
    public func setNoAuthorizationState() {
        sharedPreferences.isLogin = false
        sharedPreferences.deleteUser()
    }
    
    private func setAuthorizationState(user: User) {
        sharedPreferences.isLogin = true
        sharedPreferences.saveUser(user)
    }
    
    public func logout() {
        setNoAuthorizationState()
        firebaseService.logout()
    }
    
    private func mapToDomain(user: User) -> domain.User {
        return domain.User(uid: user.uid, email: user.email)
    }
}
