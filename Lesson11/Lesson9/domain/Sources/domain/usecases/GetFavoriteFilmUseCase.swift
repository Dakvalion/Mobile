//
//  GetFavoriteFilmUseCase.swift
//  Lesson9
//
//  Created by Daria Nikitina on 25.09.2024.
//

public class GetFavoriteFilmUseCase {
    private let movieRepository: MovieRepository
    
    public init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    public func execute() -> Movie {
        return movieRepository.getMovie()
    }
}
