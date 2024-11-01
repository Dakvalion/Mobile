//
//  ViewController.swift
//  Lesson9
//
//  Created by Daria Nikitina on 25.09.2024.
//

import UIKit
import domain
import data

class MainViewController: UIViewController {
    private let sharedPrefMovieStorage: MovieStorage = SharedPrefMovieStorage()
    private lazy var movieRepository: MovieRepository = MovieRepositoryImpl(movieStorage: sharedPrefMovieStorage)
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    private let vm: MainViewModel
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        vm = ViewModelFactory().create(modelClass: MainViewModel.self)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print(String(describing: self), "MainActivity created")
    }
    
    required init?(coder: NSCoder) {
        vm = ViewModelFactory().create(modelClass: MainViewModel.self)
        super.init(coder: coder)
        print(String(describing: self), "MainActivity created")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateFavoriteMovie(_:)), name: NSNotification.Name("FavoriteMovieUpdated"), object: nil)
    }
    
    @IBAction func GetFavoriteFilm(_ sender: Any) {
        let movie = vm.getText()
        label.text = "Save result \(movie.getName())"
    }
    
    @IBAction func SaveFilmToFavorites(_ sender: Any) {
        let result = vm.setText(movie: Movie(id: 2, name: textField.text ?? ""))
        label.text = "Save result \(result)"
    }
    
    @objc func updateFavoriteMovie(_ notification: Notification) {
        label.text = vm.favoriteMovieName
    }
}
