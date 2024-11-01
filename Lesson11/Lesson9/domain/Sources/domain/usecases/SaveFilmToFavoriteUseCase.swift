//
//  SaveFilmToFavoriteUseCase.swift
//  Lesson9
//
//  Created by Daria Nikitina on 25.09.2024.
//

import Foundation

public class SaveFilmToFavoriteUseCase {
    private let movieRepository: MovieRepository

    public init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }

    public func execute(movie: Movie) -> Bool {
        return movieRepository.saveMovie(movie: movie)
    }
}
