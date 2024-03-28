//
//  BookDetailsViewController.swift
//  Lesson3
//
//  Created by Егор Бадмаев on 27.03.2024.
//

import UIKit

/// Задание 1.7
class BookDetailsViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    var state: State = .empty {
        didSet {
            textView.text = state.text
        }
    }
    var callback: ((BookState) -> Void)?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textView.text = state.text
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        guard let bookName = textField.text,
              !bookName.isEmpty
        else { return }
        
        callback?(.book(name: bookName))
        state = .book(name: bookName)
    }
}

extension BookDetailsViewController {
    /// State должен быть один у обоих контроллеров, но из-за разницы текстов пришлось сделать так(
    enum State {
        case empty
        case book(name: String)
        
        var text: String {
            switch self {
            case .empty:
                return "Тут появится название вашей любимой книги!"
            case .book(let name):
                return "Любимая книга разработчика – \(name)"
            }
        }
    }
}
