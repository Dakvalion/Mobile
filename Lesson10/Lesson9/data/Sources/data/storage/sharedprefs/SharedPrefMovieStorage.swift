//
//  SharedPrefMovieStorage.swift
//  Lesson9
//
//  Created by Daria Nikitina on 09.10.2024.
//

import Foundation

public class SharedPrefMovieStorage: MovieStorage {
    private let key = "movie_name"
    private let dateKey = "movie_date"
    private let idKey = "movie_id"
    
    public init() {}
    
    public func get() -> Movie {
        let movieName = UserDefaults.standard.string(forKey: key) ?? "unknown"
        let movieDate = UserDefaults.standard.string(forKey: dateKey) ?? "unknown"
        let movieId = UserDefaults.standard.integer(forKey: idKey)
        return Movie(id: movieId, name: movieName, localDate: movieDate)
    }
    
    public func save(movie: Movie) -> Bool {
        UserDefaults.standard.set(movie.getId(), forKey: idKey)
        UserDefaults.standard.set(movie.getName(), forKey: key)
        UserDefaults.standard.set("\(Date())", forKey: dateKey)
        return true
    }
}
