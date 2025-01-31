//
//  LiveSupportViewController.swift
//  AppCore
//
//  Created by Özcan AKKOCA on 29.01.2025.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
import SnapKit
import CoreResource
import CoreExtension

public final class LiveSupportViewController: UIViewController {
    
    // MARK: - Views
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 150.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.registerReusableCell(LiveSupportTableViewCell.self)
        tableView.registerReusableCell(LiveSupportProductTableViewCell.self)
        tableView.contentInset = .init(top: 15, left: .zero, bottom: 15, right: .zero)
        
        dataSource = UITableViewDiffableDataSource<Int, LiveSupportMessageRowType>(tableView: tableView) { tableView, indexPath, item in
            switch item {
            case .product(let presentation):
                let cell = tableView.dequeueReusableCell(indexPath, type: LiveSupportProductTableViewCell.self)
                cell.prepare(with: presentation)
                cell.delegate = self
                return cell
            case .message(let presentation):
                let cell = tableView.dequeueReusableCell(indexPath, type: LiveSupportTableViewCell.self)
                cell.prepare(with: presentation)
                cell.delegate = self
                return cell
            }
        }
        
        tableView.dataSource = dataSource
        return tableView
    }()
    
    // MARK: - Properties
    var presenter: LiveSupportPresenterProtocol!
    private var itemPresentations: [LiveSupportMessageRowType] = .emptyValue
    private var dataSource: UITableViewDiffableDataSource<Int, LiveSupportMessageRowType>!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.loadTitle()
        presenter.viewDidLoad()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappear()
    }
    
}

// MARK: - LiveSupportViewProtocol
extension LiveSupportViewController: LiveSupportViewProtocol {
    nonisolated func handleOutput(_ output: LiveSupportPresenterOutput) {
        DispatchQueue.main.async { [weak self] in
            self?.updateUIWithOutput(output)
        }
    }
    
    func updateUIWithOutput(_ output: LiveSupportPresenterOutput) {
        switch output {
        case .setTitle(let text):
            navigationItem.title = text
        case .setListItems(let items):
            applySnapshot(items)
            scrollToBottom()
        case .showErrorMessage(let message):
            showErrorMessage(message)
        case .showExitPopup:
            showExitPopup()
        }
    }

}

// MARK: - UI
private extension LiveSupportViewController {
    func setupUI() {
        view.backgroundColor = CoreColors.white11
        view.addSubviewAndMakeConstraints(tableView)
    }
    
    func applySnapshot(_ items: [LiveSupportMessageRowType]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, LiveSupportMessageRowType>()
        snapshot.appendSections([0])
        snapshot.appendItems(items, toSection: 0)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
    
    func scrollToBottom(animated: Bool = true) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let lastSection = self.tableView.numberOfSections - 1
            if lastSection >= 0 {
                let lastRow = self.tableView.numberOfRows(inSection: lastSection) - 1
                if lastRow >= 0 {
                    let indexPath = IndexPath(row: lastRow, section: lastSection)
                    self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: animated)
                }
            }
        }
    }
    
    func showErrorMessage(_ message: String) {
        let alert = UIAlertController(title: CoreLocalize.General.ErrorTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: CoreLocalize.General.OkButton, style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func showExitPopup() {
        let alert = UIAlertController(title: CoreLocalize.General.ExitButton, message: CoreLocalize.General.AssistantExitConfirmation, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: CoreLocalize.General.YesButton, style: .destructive) { [weak self] _ in
            self?.presenter.handleExitRequest()
        })
        
        alert.addAction(UIAlertAction(title: CoreLocalize.General.NoButton, style: .cancel, handler: nil))
        
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension LiveSupportViewController: UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemPresentations.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch itemPresentations[indexPath.row] {
        case .product(let presentation):
            let cell = tableView.dequeueReusableCell(indexPath, type: LiveSupportProductTableViewCell.self)
            cell.prepare(with: presentation)
            cell.delegate = self
            return cell
        case .message(let presentation):
            let cell = tableView.dequeueReusableCell(indexPath, type: LiveSupportTableViewCell.self)
            cell.prepare(with: presentation)
            cell.delegate = self
            return cell
        }
    }
}

// MARK: - LiveSupportProductTableViewCellDelegate
extension LiveSupportViewController: LiveSupportProductTableViewCellDelegate {
    nonisolated func didSelectProduct(_ cell: LiveSupportProductTableViewCell, index: Int) {
        DispatchQueue.main.async {
            if let indexPath = self.tableView.indexPath(for: cell) {
                self.presenter.didSelectProduct(at: indexPath.row, optionIndex: index)
            }
        }
    }
}

// MARK: - LiveSupportTableViewCellDelegate
extension LiveSupportViewController: LiveSupportTableViewCellDelegate {
    nonisolated func didSelectOption(_ cell: LiveSupportTableViewCell, index: Int) {
        DispatchQueue.main.async {
            if let indexPath = self.tableView.indexPath(for: cell) {
                self.presenter.didSelectOption(at: indexPath.row, optionIndex: index)
            }
        }
    }
}
