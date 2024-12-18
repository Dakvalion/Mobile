//
//  TodoCell.swift
//  Lesson13
//
//  Created by Daria Nikitina on 03.12.2024.
//

import UIKit
import Kingfisher

// Реализация TodoViewHolder
class TodoCell: UITableViewCell {
    private let textViewTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var checkBoxCompleted: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        return button
    }()
    
    private lazy var todoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(textViewTitle)
        addSubview(checkBoxCompleted)
        addSubview(todoImageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            todoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            todoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            todoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            todoImageView.widthAnchor.constraint(equalToConstant: 40),
            todoImageView.heightAnchor.constraint(equalToConstant: 40),
            
            textViewTitle.leadingAnchor.constraint(equalTo: todoImageView.trailingAnchor, constant: 16),
            textViewTitle.centerYAnchor.constraint(equalTo: centerYAnchor),
            textViewTitle.trailingAnchor.constraint(equalTo: checkBoxCompleted.leadingAnchor, constant: -16),
            
            checkBoxCompleted.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            checkBoxCompleted.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkBoxCompleted.widthAnchor.constraint(equalToConstant: 24),
            checkBoxCompleted.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func configure(with todo: Todo, imageConfig: ImageConfig? = nil) {
        textViewTitle.text = todo.title
        if todo.completed {
            checkBoxCompleted.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            checkBoxCompleted.tintColor = .green
        } else {
            checkBoxCompleted.setImage(UIImage(systemName: "xmark.square.fill"), for: .normal)
            checkBoxCompleted.tintColor = .red
        }
        if let imageConfig = imageConfig {
            todoImageView.kf.setImage(
                with: imageConfig.url,
                placeholder: imageConfig.placeholder,
                options: imageConfig.options
            )
        } else {
            todoImageView.image = nil
        }
    }
}
