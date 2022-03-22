//
//  RegionCell.swift
//  TestApp
//
//  Created by Алексей Серёжин on 21.03.2022.
//

import UIKit

final class RegionCell: UITableViewCell {

    // MARK: - Private properties

    private lazy var label: UILabel = UILabel()

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    func apply(region: String) {
        self.label.text = region
    }

    // MARK: - Private methods

    private func configure() {
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.label)

        let constraints = [
            self.contentView.leadingAnchor.constraint(equalTo: self.label.leadingAnchor, constant: -16),
            self.contentView.topAnchor.constraint(equalTo: self.label.topAnchor, constant: -10),
            self.contentView.trailingAnchor.constraint(equalTo: self.label.leadingAnchor, constant: 16),
            self.contentView.bottomAnchor.constraint(equalTo: self.label.bottomAnchor, constant: 10),
            self.label.heightAnchor.constraint(equalToConstant: 25)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
