//
//  ViewController.swift
//  Lesson9
//
//  Created by Daria Nikitina on 25.09.2024.
//

import UIKit
import domain
import data

class ViewController: UIViewController {
    private let sharedPrefMovieStorage: MovieStorage = SharedPrefMovieStorage()
    private lazy var movieRepository: MovieRepository = MovieRepositoryImpl(movieStorage: sharedPrefMovieStorage)

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func GetFavoriteFilm(_ sender: Any) {
        let movie = GetFavoriteFilmUseCase(movieRepository: movieRepository).execute()
        label.text = "Save result \(movie.getName())"
    }
    
    @IBAction func SaveFilmToFavorites(_ sender: Any) {
        let result = SaveFilmToFavoriteUseCase(movieRepository: movieRepository).execute(movie: Movie(id: 2, name: textField.text ?? ""))
        label.text = "Save result \(result)"
    }
}
