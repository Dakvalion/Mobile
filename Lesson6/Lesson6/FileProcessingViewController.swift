//
//  FileProcessingViewController.swift
//  Lesson6
//
//  Created by Дарья Никитина on 13.05.2024.
//

import UIKit

class FileProcessingViewController: UIViewController, UIDocumentPickerDelegate {
    
    var isExporting: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Choose File", style: .plain, target: self, action: #selector(presentDocumentPicker))
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard !isExporting else {
            isExporting = false
            return
        }
        guard let selectedFileURL = urls.first,
              let resultFileUrl = convert(fileURL: selectedFileURL) else {
            print("❗️Ошибка выбора файла")
            return
        }
        isExporting = true
        let documentPicker = UIDocumentPickerViewController(url: resultFileUrl, in: .exportToService)
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .formSheet
        present(documentPicker, animated: true, completion: nil)
    }
    
    func convert(fileURL: URL) -> URL? {
        do {
            let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
            let attributedString = NSAttributedString(string: fileContents)
            let rtfData = try attributedString.data(
                from: NSRange(location: 0, length: attributedString.length),
                documentAttributes: [.documentType: NSAttributedString.DocumentType.rtf]
            )
            let rtfFileURL = fileURL.deletingPathExtension().appendingPathExtension("rtf")
            try rtfData.write(to: rtfFileURL)
            return rtfFileURL
        } catch {
            print("❗️Ошибка конвертации: \(error)")
            return nil
        }
    }
    
    @objc func presentDocumentPicker() {
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.text"], in: .import)
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .fullScreen
        present(documentPicker, animated: true, completion: nil)
    }
    
    func shareConvertedFile(url: URL) {
        let documentController = UIDocumentInteractionController(url: url)
        documentController.presentOptionsMenu(from: view.bounds, in: view, animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
}
