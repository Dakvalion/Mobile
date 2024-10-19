//
//  FirebaseServiceImpl.swift
//  RecipeGenius
//
//  Created by Daria Nikitina on 11.10.2024.
//

import FirebaseAuth

public class FirebaseServiceImpl: FirebaseService {
    
    var auth: Auth?
    
    public init() {
        auth = Auth.auth()
    }
    
    public func signIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        auth?.signIn(withEmail: email, password: password) { [weak self] (result, error) in
            guard let self else { return }
            if let error = error {
                completion(.failure(error))
            } else {
                guard let user = result?.user else {
                    completion(.failure(FirebaseError.noUser))
                    return
                }
                completion(.success(self.mapToData(from: user)))
            }
        }
    }
    
    public func createAccount(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        auth?.createUser(withEmail: email, password: password) { [weak self] (result, error) in
            guard let self else { return }
            if let error = error {
                completion(.failure(error))
            } else {
                guard let user = result?.user else {
                    completion(.failure(FirebaseError.noUser))
                    return
                }
                completion(.success(self.mapToData(from: user)))
            }
        }
    }
      
    private func mapToData(from user: FirebaseAuth.User) -> User {
        return User(uid: user.uid, name: "", email: "")
    }
}
