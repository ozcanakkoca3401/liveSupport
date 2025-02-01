//
//  LiveSupportSubItemView.swift
//  LiveSupportModule
//
//  Created by Özcan AKKOCA on 30.01.2025.
//

import UIKit
import CoreResource

protocol LiveSupportSubItemDelegate: AnyObject {
    func didSelectOption(_ view: LiveSupportSubItemView, index: Int)
}

final class LiveSupportSubItemView: UIView {
    
    // MARK: - Views
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [messageLabel, optionsStackView])
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.textAlignment = .left
        label.font = UIFont.regular(14)
        return label
    }()
    
    private lazy var optionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.isHidden = true
        return stackView
    }()
    
    // MARK: - Properties
    weak var delegate: LiveSupportSubItemDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Prepare
extension LiveSupportSubItemView {
    func prepare(with presentation: LiveSupportSubItemViewPresentation) {
        containerView.backgroundColor = presentation.backgroundColor
        messageLabel.textColor = presentation.messageTextColor
        messageLabel.text = presentation.messageText
        optionsStackView.isHidden = presentation.options.isEmpty
        
        optionsStackView.removeAllArrangedSubviews()
        for (index, item) in presentation.options.enumerated() {
            optionsStackView.addArrangedSubview(createOptionView(title: item.key,
                                                                   tag: index))
        }
    }

}

// MARK: - UI
private extension LiveSupportSubItemView {
    func setupUI() {
        addSubviewAndMakeConstraints(containerView)
        containerView.addSubviewAndMakeConstraints(stackView,
                                                   insets: .init(top: 12, left: 12, bottom: 12, right: 12))
    }
    
    func createOptionView(title: String, tag: Int) -> UIView {
        let containerView = UIView()
        containerView.tag = tag
        containerView.backgroundColor = CoreColors.lightPurple11
        containerView.layer.cornerRadius = 4
        containerView.layer.masksToBounds = true
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = CoreColors.border11.cgColor
        
        let label = UILabel()
        label.text = title
        label.font = UIFont.bold(14)
        label.textColor = CoreColors.purple11
        label.numberOfLines = 0
        label.textAlignment = .center
        
        containerView.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 16, left: 8, bottom: 16, right: 8))
        }
        
        containerView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(optionTapped(_:)))
        containerView.addGestureRecognizer(tapGesture)
        
        return containerView
    }


}

// MARK: Actions
private extension LiveSupportSubItemView {
    @objc func optionTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedView = sender.view else { return }
        delegate?.didSelectOption(self, index: tappedView.tag)
    }
}
