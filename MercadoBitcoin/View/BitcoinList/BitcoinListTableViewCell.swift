//
//  BitcoinListTableViewCell.swift
//  MercadoBitcoin
//
//  Created by NJ Development on 17/05/23.
//

import UIKit

final class BitcoinListTableViewCell: UITableViewCell {
    let exchangeIdLabel = UILabel()
    let nameLabel = UILabel()
    let volumeLabel = UILabel()

    private lazy var cellBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.96, alpha: 1.00)
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()

    private lazy var vStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [exchangeIdLabel, nameLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()

    private lazy var hStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [vStack, volumeLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()

    private let kMargins: CGFloat = 10
    private let kLabelHeight: CGFloat = 20

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        exchangeIdLabel.text = nil
        nameLabel.text = nil
        volumeLabel.text = nil
    }

    private func setupCell() {
        contentView.backgroundColor = UIColor(red: 1.00, green: 0.58, blue: 0.08, alpha: 1.00)
        contentView.addSubview(cellBackgroundView)
        cellBackgroundView.addSubview(hStack)

        NSLayoutConstraint.activate([
            cellBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: kMargins),
            cellBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: kMargins),
            cellBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -kMargins),
            cellBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -kMargins),

            hStack.topAnchor.constraint(equalTo: cellBackgroundView.topAnchor, constant: kMargins),
            hStack.leadingAnchor.constraint(equalTo: cellBackgroundView.leadingAnchor, constant: kMargins),
            hStack.trailingAnchor.constraint(equalTo: cellBackgroundView.trailingAnchor, constant: -kMargins),
            hStack.bottomAnchor.constraint(equalTo: cellBackgroundView.bottomAnchor, constant: -kMargins)
        ])

        exchangeIdLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            exchangeIdLabel.widthAnchor.constraint(equalToConstant: contentView.bounds.width),
            exchangeIdLabel.heightAnchor.constraint(equalToConstant: kLabelHeight)
        ])

        setupLabels()
    }

    private func setupLabels() {
        exchangeIdLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        exchangeIdLabel.numberOfLines = 0
        exchangeIdLabel.textColor = .black

        nameLabel.font = .systemFont(ofSize: 14, weight: .regular)
        nameLabel.textColor = UIColor.darkGray
        nameLabel.numberOfLines = 0

        volumeLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        volumeLabel.textAlignment = .right
        volumeLabel.numberOfLines = 0
        volumeLabel.adjustsFontSizeToFitWidth = true
        volumeLabel.minimumScaleFactor = 0.5
    }

    func configure(list: Bitcoin?) {
        guard let list, let volume = list.volume else { return }

        DispatchQueue.main.async {
            self.exchangeIdLabel.text = list.exchangeId
            self.nameLabel.text = list.name
            self.volumeLabel.text = self.cleanDollars(String(volume))
            self.volumeLabel.textColor = volume == 0.0 ? .systemBlue : UIColor(red: 0.00, green: 0.40, blue: 0.00, alpha: 1.00)
        }
    }
}
