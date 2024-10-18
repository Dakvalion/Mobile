//
//  AuthRepositoryImpl.swift
//  RecipeGenius
//
//  Created by Daria Nikitina on 11.10.2024.
//

import domain

public class AuthRepositoryImpl: AuthRepository {
    private let firebaseService: FirebaseService
    private var result: Result<domain.User, Error>?
    
    public init(firebaseService: FirebaseService) {
        self.firebaseService = firebaseService
    }
    
    public func signIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        firebaseService.signIn(email: email, password: password) { [weak self] result in
            switch result {
            case .success(let user):
                completion(.success(User(uid: user.uid, name: user.name, email: user.email)))
            case .failure(let failure):
                completion(failure)
            }
        }
    }
    
    public func createAccount(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        firebaseService.createAccount(email: email, password: password) { [weak self] result in
            switch result {
            case .success(let user):
                completion(.success(User(uid: user.uid, name: user.name, email: user.email)))
            case .failure(let failure):
                completion(failure)
            }
        }
    }
}
