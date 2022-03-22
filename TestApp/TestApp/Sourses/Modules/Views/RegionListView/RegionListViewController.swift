//
//  RegionListViewController.swift
//  TestApp
//
//  Created by Алексей Серёжин on 21.03.2022.
//

import UIKit
import Combine

class RegionListViewController: UIViewController {

    // MARK: - Nested

    private enum SectionType: CaseIterable {
        case section
    }

    // MARK: - Private properties

    private let viewModel: IRegionListViewModel
    private let selection = PassthroughSubject<Int, Never>()

    private var bin: Set<AnyCancellable> = []
    private lazy var tableView: UITableView = UITableView()
    private lazy var dataSource = UITableViewDiffableDataSource<SectionType, String>(
        tableView: self.tableView,
        cellProvider: self.cellProvider
    )

    // MARK: - Initialization

    init(viewModel: IRegionListViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - LifeCircle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configure()
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selection.send(indexPath.item)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Private methods

    private func configure() {
        self.title = "Regions"

        self.configureTableView()
        self.bind()
    }

    private func configureTableView() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.tableView)

        let constraints = [
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ]

        NSLayoutConstraint.activate(constraints)

        self.tableView.separatorStyle = .none
        self.tableView.register(RegionCell.self, forCellReuseIdentifier: "\(RegionCell.self)")
    }

    private func bind() {
        self.viewModel.bind(selections: self.selection.eraseToAnyPublisher())
        self.viewModel.statePublisher
            .sink { [weak self] state in
                switch state {
                case .regions(let values):
                    self?.update(with: values)
                }
            }.store(in: &self.bin)
    }

    private func cellProvider(
        tableView: UITableView,
        indexPath: IndexPath,
        itemType: String
    ) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(RegionCell.self)", for: indexPath)

        if let cell = cell as? RegionCell {
            cell.apply(region: itemType)
        }

        return cell
    }

    private func update(with regions: [String], animate: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<SectionType, String>()
        snapshot.appendSections(SectionType.allCases)
        snapshot.appendItems(regions, toSection: .section)

        self.dataSource.apply(snapshot, animatingDifferences: animate)
    }
}
