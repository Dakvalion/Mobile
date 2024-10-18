//
//  Movie.swift
//  Lesson9
//
//  Created by Daria Nikitina on 09.10.2024.
//

import Foundation

public class Movie {
    private let id: Int
    private let name: String
    private let localDate: String
    
    public init(id: Int, name: String, localDate: String) {
        self.id = id
        self.name = name
        self.localDate = localDate
    }
    
    public func getName() -> String {
        return name
    }
    
    public func getId() -> Int {
        return id
    }
    
    public func getLocalDate() -> String {
        return localDate
    }
}
