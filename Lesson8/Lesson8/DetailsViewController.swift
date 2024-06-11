//
//  DetailsViewController.swift
//  Lesson8
//
//  Created by Дарья Никитина on 04.06.2024.
//

import UIKit

class DetailsViewController: UIViewController {
    var header = "Московский Кремль"
    var text = "Московский Кремль — это музей-заповедник, расположенный в самом сердце столицы России. Он включает в себя множество достопримечательностей, таких как Соборная площадь, Большой Кремлевский Дворец, Алмазный Фонд и Оружейную Палату, а также Патриарший Дворец и Звонницу."
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = header
        descriptionLabel.text = text
    }
}
