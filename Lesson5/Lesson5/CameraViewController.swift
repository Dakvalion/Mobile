//
//  CameraViewController.swift
//  Lesson5
//
//  Created by Дарья Никитина on 22.04.2024.
//

import UIKit

class CameraViewController: UIViewController,
                            UIImagePickerControllerDelegate,
                            UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Добавление UITapGestureRecognizer для обработки нажатия на UIImageView
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        imageView.addGestureRecognizer(tapGesture)
    }
    
    @objc func imageViewTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        if let pickedImage = info[.originalImage] as? UIImage {
            imageView.image = pickedImage
            
            if let data = pickedImage.jpegData(compressionQuality: 1) ?? pickedImage.pngData() {
                let fileName = FileManager.documentsDirectory.appendingPathComponent("IMAGE_\(Date())_")
                do {
                    try data.write(to: fileName, options: .atomic)
                    print("Изображение успешно сохранено.")
                } catch {
                    print("Ошибка при сохранении изображения: \(error)")
                }
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
