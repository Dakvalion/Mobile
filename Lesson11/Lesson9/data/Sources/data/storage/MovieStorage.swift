//
//  MovieStorage.swift
//  Lesson9
//
//  Created by Daria Nikitina on 09.10.2024.
//

import Foundation

public protocol MovieStorage {
    func get() -> Movie
    func save(movie: Movie) -> Bool
}
