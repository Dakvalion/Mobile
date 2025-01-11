//
//  RecyclerViewController.swift
//  Lesson12
//
//  Created by Daria Nikitina on 17.11.2024.
//

import UIKit

struct HistoricalEvent {
    let title: String
    let year: String
    let description: String
    let imageName: String
}

class RecyclerViewController: UIViewController {
    private var collectionView: UICollectionView!
    
    private let events: [HistoricalEvent] = [
        HistoricalEvent(
            title: "Открытие Америки",
            year: "1492",
            description: "Христофор Колумб достиг берегов Америки, что положило начало эпохе великих географических открытий",
            imageName: "columbus"
        ),
        HistoricalEvent(
            title: "Первая печатная книга",
            year: "1455",
            description: "Иоганн Гутенберг напечатал первую книгу с помощью подвижных литер - Библию Гутенберга",
            imageName: "gutenberg"
        ),
        HistoricalEvent(
            title: "Падение Константинополя",
            year: "1453",
            description: "Османская империя захватила Константинополь, что означало конец Византийской империи",
            imageName: "constantinople"
        )
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(HistoricalEventCell.self, forCellWithReuseIdentifier: "HistoricalEventCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension RecyclerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HistoricalEventCell", for: indexPath) as? HistoricalEventCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: events[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 32
        return CGSize(width: width, height: 300)
    }
}
