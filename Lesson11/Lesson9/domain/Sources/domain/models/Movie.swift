//
//  Movie.swift
//  Lesson9
//
//  Created by Daria Nikitina on 25.09.2024.
//

import Foundation

public class Movie {
    private var id: Int
    private var name: String
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    public func getId() -> Int {
        return id
    }
    
    public func getName() -> String {
        return name
    }
}
