//
//  MVVMHomeViewController.swift
//  HomeModule
//
//  Created by Özcan AKKOCA on 28.01.2025.
//
//

import UIKit
import SnapKit
import CoreResource
import CoreExtension

public final class MVVMHomeViewController: UIViewController {
    
    // MARK: - Views
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
       // tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 150.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
       // tableView.registerReusableCell(ProductsTableViewCell.self)
        return tableView
    }()

    // MARK: - Properties
    var viewModel: HomeViewModelProtocol!

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
}

// MARK: - Binding
private extension MVVMHomeViewController {
    func bindViewModel() {
        viewModel.outputHandler = { [weak self] outputValue in
            DispatchQueue.main.async {
                self?.handleOutput(outputValue)
            }
        }
    }
    
    func handleOutput(_ output: HomeViewModel.HomeOutput) {
        switch output {
        case .setLoading(_):
            break
        case .showError(_):
            break
        }
    }
}

// MARK: - UI
private extension MVVMHomeViewController {
    func setupUI() {
        title = "Ana Sayfa"
        view.backgroundColor = CoreColors.white11
        view.addSubviewAndMakeConstraints(tableView)
    }
}

// MARK: - Actions
private extension MVVMHomeViewController {
    @objc func liveSupportTapped() {
        viewModel.liveSupportTapped()
    }
}
