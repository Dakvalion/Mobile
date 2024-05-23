//
//  NotebookViewController.swift
//  Lesson6
//
//  Created by Дарья Никитина on 12.05.2024.
//

import UIKit

class NotebookViewController: UIViewController {
    
    @IBOutlet weak var fileNameTextField: UITextField!
    
    @IBOutlet weak var quoteTextField: UITextField!
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let fileName = fileNameTextField.text, !fileName.isEmpty,
              let quote = quoteTextField.text, !quote.isEmpty else { return }
        
        let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            try quote.write(to: fileURL, atomically: true, encoding: .utf8)
            print("✅ Успех сохранения")
        } catch {
            print("❗️Ошибка сохранения: \(error)")
        }
    }
    
    @IBAction func loadButtonTapped(_ sender: Any) {
        guard let fileName = fileNameTextField.text,
              !fileName.isEmpty else { return }
        
        let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            let quote = try String(contentsOf: fileURL, encoding: .utf8)
            quoteTextField.text = quote
            print("✅ Успех загрузки")
        } catch {
            print("❗️Ошибка загрузки: \(error)")
        }
    }
    
    func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
}
