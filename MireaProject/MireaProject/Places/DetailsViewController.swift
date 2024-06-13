//
//  DetailsViewController.swift
//  MireaProject
//
//  Created by Дарья Никитина on 13.06.2024.
//

import UIKit
import YandexMapsMobile

class DetailsViewController: UIViewController {
    var address = "Красная площадь, 1"
    var place: Place = Place(name: "Московский Кремль",
                             description: "Московский Кремль — это музей-заповедник, расположенный в самом сердце столицы России. Он включает в себя множество достопримечательностей, таких как Соборная площадь, Большой Кремлевский Дворец, Алмазный Фонд и Оружейную Палату, а также Патриарший Дворец и Звонницу.",
                             imagePath: "star.fill",
                             point: YMKPoint(latitude: 55.751476, longitude: 37.618879))
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = place.name
        descriptionLabel.text = place.description
        addressLabel.text = address
        iconImageView.image = UIImage(systemName: place.imagePath)
    }
    
    @IBAction func panoramaButtonTapped(_ sender: Any) {
        let panorama = PanoramaViewController()
        panorama.position = place.point
        present(panorama, animated: true)
    }
}
