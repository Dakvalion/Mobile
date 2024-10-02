//
//  Movie.swift
//  Lesson9
//
//  Created by Daria Nikitina on 25.09.2024.
//

import Foundation

class Movie {
    private var id: Int
    private var name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    func getId() -> Int {
        return id
    }
    
    func getName() -> String {
        return name
    }
}
