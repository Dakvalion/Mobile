//
//  MovieRepository.swift
//  Lesson9
//
//  Created by Daria Nikitina on 25.09.2024.
//

import Foundation
import domain

public class MovieRepositoryImpl: MovieRepository {
    private let movieStorage: MovieStorage
    
    public init(movieStorage: MovieStorage) {
        self.movieStorage = movieStorage
    }
    
    public func saveMovie(movie: domain.Movie) -> Bool {
        return movieStorage.save(movie: mapToStorage(movie: movie))
    }
    
    public func getMovie() -> domain.Movie {
        let movie = movieStorage.get()
        return mapToDomain(movie: movie)
    }
    
    private func mapToStorage(movie: domain.Movie) -> data.Movie {
        return data.Movie(id: 2, name: movie.getName(), localDate: "\(Date())")
    }
    
    private func mapToDomain(movie: data.Movie) -> domain.Movie {
        return domain.Movie(id: movie.getId(), name: movie.getName())
    }
}
