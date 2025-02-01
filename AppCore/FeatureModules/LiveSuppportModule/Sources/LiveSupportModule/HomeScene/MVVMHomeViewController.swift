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

public final class MVVMHomeViewController: UIViewController {
    
    // MARK: - Views
    private lazy var liveSupportButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(CoreColors.purple11, for: .normal)
        button.backgroundColor = .white
        button.setTitle("Canli Destek", for: .normal)
        button.addTarget(self, action: #selector(liveSupportTapped), for: .touchUpInside)
        button.titleLabel?.font = UIFont.regular(14, weight: .medium)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = CoreColors.purple11.cgColor
        return button
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
        
        view.addSubview(liveSupportButton)
        liveSupportButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
    }
}

// MARK: - Actions
private extension MVVMHomeViewController {
    @objc func liveSupportTapped() {
        viewModel.liveSupportTapped()
    }
}
