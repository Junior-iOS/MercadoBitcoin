//
//  DetailsView.swift
//  MercadoBitcoin
//
//  Created by NJ Development on 17/05/23.
//

import UIKit

final class DetailsView: UIView {
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.96, alpha: 1.00)
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()

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
        label.font = .systemFont(ofSize: 50, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()

    private let volumeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()

    var coin: Bitcoin?
    let screenSize = UIScreen.main.bounds

    init(coin: Bitcoin?) {
        super.init(frame: .zero)
        self.coin = coin
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        backgroundColor = UIColor(red: 0.12, green: 0.13, blue: 0.14, alpha: 1.00)

        DispatchQueue.main.async {
            guard let coin = self.coin, let volume = coin.volume else { return }

            self.nameLabel.text = coin.name
            self.volumeLabel.text = self.cleanDollars(String(volume))
            self.volumeLabel.textColor = volume == 0.0 ? .systemBlue : UIColor(red: 0.00, green: 0.40, blue: 0.00, alpha: 1.00)
        }

        setupConstraints()
    }

    private func setupConstraints() {
        addSubviews(nameLabel, contentView, imageView)
        contentView.addSubviews(volumeLabel)

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.heightAnchor.constraint(equalToConstant: screenSize.height / 2),

            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
            imageView.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200),

            volumeLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            volumeLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            volumeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            volumeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
