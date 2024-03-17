//
//  DialogViewController.swift
//  SecondPractice
//
//  Created by Дарья Никитина on 12.03.2024.
//

import UIKit

class DialogViewController: UIViewController {
    
    @IBOutlet weak var pseudoSnackbarButton: UIButton!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var progressDialog: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressDialog.hidesWhenStopped = false
        progressDialog.stopAnimating()
    }
    
    @IBAction func pseudoSnackbarButtonAction(_ sender: Any) {
        let alertController = UIAlertController(title: nil, message: "Это сообщение", preferredStyle: .alert)
        alertController.view.backgroundColor = UIColor.black
        alertController.view.alpha = 0.6
        alertController.view.layer.cornerRadius = 15
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        alertController.addAction(UIAlertAction(title: "Undo", style: .cancel))
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func timePickerEndEditing(_ sender: Any) {
        print(timePicker.date)
    }
    
    @IBAction func datePickerEndEditing(_ sender: Any) {
        print(datePicker.date)
    }
    
    @IBAction func startProgressButtonAction(_ sender: Any) {
        progressDialog.startAnimating()
    }
    
    @IBAction func stopProgressButtonAction(_ sender: Any) {
        progressDialog.stopAnimating()
    }
}
