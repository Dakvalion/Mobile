//
//  MainViewModel.swift
//  Lesson9
//
//  Created by Daria Nikitina on 01.11.2024.
//

import Foundation
import domain

class MainViewModel: ViewModel {
    private let movieRepository: MovieRepository
    
    var favoriteMovieName = ""
    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
        super.init()
        print(String(describing: self), "MainViewModel created")
    }
    
    deinit {
        print(String(describing: self), "MainViewModel cleared")
    }
    
    func setText(movie: Movie) -> Bool {
        let result = SaveFilmToFavoriteUseCase(movieRepository: movieRepository).execute(movie: movie)
        favoriteMovieName = movie.getName()
        NotificationCenter.default.post(name: Notification.Name("FavoriteMovieUpdated"), object: nil)
        return result
    }
    
    func getText() -> Movie {
        let movie = GetFavoriteFilmUseCase(movieRepository: movieRepository).execute()
        return movie
    }
}
