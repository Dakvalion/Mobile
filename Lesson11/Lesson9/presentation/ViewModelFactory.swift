//
//  ViewModelFactory.swift
//  Lesson9
//
//  Created by Daria Nikitina on 01.11.2024.
//

import data
import domain

class ViewModelFactory {
    func create<T>(modelClass: T.Type) -> T where T : ViewModel {
        let sharedPrefMovieStorage: MovieStorage = SharedPrefMovieStorage()
        let movieRepository: MovieRepository = MovieRepositoryImpl(movieStorage: sharedPrefMovieStorage)
        return MainViewModel(movieRepository: movieRepository) as! T
    }
}
