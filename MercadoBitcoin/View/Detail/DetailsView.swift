//
//  DetailsView.swift
//  MercadoBitcoin
//
//  Created by Junior Silva on 09/02/23.
//

import UIKit

final class DetailsView: UIView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "bitcoin")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let volumeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var coin: Bitcoin?

    init(coin: Bitcoin?) {
        super.init(frame: .zero)
        self.coin = coin
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        DispatchQueue.main.async {
            guard let coin = self.coin, let volume = coin.volume else { return }
            
            self.nameLabel.text = coin.name
            self.volumeLabel.text = "USD \(String(describing: volume))"
        }
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        addSubviews(imageView, nameLabel, volumeLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 50),
            
            volumeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            volumeLabel.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor),
            volumeLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
