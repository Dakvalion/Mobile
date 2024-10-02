//
//  GetFavoriteFilmUseCase.swift
//  Lesson9
//
//  Created by Daria Nikitina on 25.09.2024.
//

class GetFavoriteFilmUseCase {
    private let movieRepository: MovieRepository

    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }

    func execute() -> Movie {
        return movieRepository.getMovie()
    }
}
