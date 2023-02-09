//
//  BitcoinListTableViewCell.swift
//  MercadoBitcoin
//
//  Created by Junior Silva on 09/02/23.
//

import UIKit

final class BitcoinListTableViewCell: UITableViewCell {
    
    let exchangeIdLabel = UILabel()
    let nameLabel = UILabel()
    let volumeLabel = UILabel()
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [exchangeIdLabel, nameLabel, volumeLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    
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
        contentView.addSubview(vStack)
        
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            vStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            vStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
            vStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
        exchangeIdLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            exchangeIdLabel.widthAnchor.constraint(equalToConstant: contentView.bounds.width),
            exchangeIdLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        setupLabels()
    }
    
    private func setupLabels() {
        exchangeIdLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        exchangeIdLabel.numberOfLines = 0

        nameLabel.font = .systemFont(ofSize: 14, weight: .regular)
        nameLabel.textColor = UIColor.darkGray

        volumeLabel.font = .systemFont(ofSize: 15, weight: .regular)
        volumeLabel.textColor = UIColor.darkGray
    }
    
    func configure(list: Bitcoin?) {
        guard let list = list, let volume = list.volume else { return }
        DispatchQueue.main.async {
            self.exchangeIdLabel.text = list.exchangeId
            self.nameLabel.text = list.name
            self.volumeLabel.text = "USD \(String(describing: volume))"
        }
    }
}
