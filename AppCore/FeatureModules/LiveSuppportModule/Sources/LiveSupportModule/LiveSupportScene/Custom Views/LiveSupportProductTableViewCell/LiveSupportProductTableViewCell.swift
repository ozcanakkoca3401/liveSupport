//
//  LiveSupportProductTableViewCell.swift
//  LiveSupportModule
//
//  Created by Özcan AKKOCA on 30.01.2025.
//

import UIKit
import CoreExtension
import CoreResource

protocol LiveSupportProductTableViewCellDelegate: AnyObject {
    func didSelectProduct(_ cell: LiveSupportProductTableViewCell, index: Int)
}

final class LiveSupportProductTableViewCell: UITableViewCell {
    
    // MARK: - Views
    private let containerView: UIView = UIView()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.addSubview(scrollStackView)
        
        scrollStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
        }

        return scrollView
    }()
    
    private lazy var scrollStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        return stackView
    }()
    
    // MARK: - Properties
    weak var delegate: LiveSupportProductTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        scrollStackView.removeAllArrangedSubviews()
    }
    
    func prepare(with presentation: LiveSupportProductTableViewCellPresentation) {
        presentation.products.forEach { productPresentation in
            let productView = LiveSupportProductItemView()
            productView.delegate = self
            productView.prepare(with: productPresentation)
            scrollStackView.addArrangedSubview(productView)
        }
        
        if !presentation.products.isEmpty {
            scrollStackView.addArrangedSubview(UIView())
        }
    }
}

// MARK: - UI
private extension LiveSupportProductTableViewCell {
    func setupUI() {
        selectionStyle = .none
        layer.masksToBounds = true
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        
        contentView.addSubviewAndMakeConstraints(containerView, insets: .init(top: 8, left: 8, bottom: 8, right: 16))
        containerView.addSubviewAndMakeConstraints(scrollView)
    }
}

// MARK: - LiveSupportProductItemViewDelegate
extension LiveSupportProductTableViewCell: LiveSupportProductItemViewDelegate {
    func didSelectProduct(_ view: LiveSupportProductItemView) {
        DispatchQueue.main.async {
            guard let index = self.scrollStackView.arrangedSubviews.firstIndex(of: view) else { return }
            self.delegate?.didSelectProduct(self, index: index)
        }
    }
}
