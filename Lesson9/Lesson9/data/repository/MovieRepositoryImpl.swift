//
//  MovieRepository.swift
//  Lesson9
//
//  Created by Daria Nikitina on 25.09.2024.
//

import Foundation

class MovieRepositoryImpl: MovieRepository {
    func saveMovie(movie: Movie) -> Bool {
        UserDefaults.standard.set(movie.getId(), forKey: "favorite_movie_id")
        UserDefaults.standard.set(movie.getName(), forKey: "favorite_movie_name")
        return true
    }
    
    func getMovie() -> Movie {
        return Movie(id: UserDefaults.standard.integer(forKey: "favorite_movie_id"), name: UserDefaults.standard.string(forKey: "favorite_movie_name") ?? "")
    }
}
