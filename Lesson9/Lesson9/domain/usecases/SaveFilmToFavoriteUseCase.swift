//
//  SaveFilmToFavoriteUseCase.swift
//  Lesson9
//
//  Created by Daria Nikitina on 25.09.2024.
//

import Foundation

class SaveFilmToFavoriteUseCase {
    private let movieRepository: MovieRepository

    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }

    func execute(movie: Movie) -> Bool {
        return movieRepository.saveMovie(movie: movie)
    }
}