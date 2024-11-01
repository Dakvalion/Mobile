//
//  MovieRepository.swift
//  Lesson9
//
//  Created by Daria Nikitina on 25.09.2024.
//

import Foundation

public protocol MovieRepository {
    func saveMovie(movie: Movie) -> Bool
    func getMovie() -> Movie
}
