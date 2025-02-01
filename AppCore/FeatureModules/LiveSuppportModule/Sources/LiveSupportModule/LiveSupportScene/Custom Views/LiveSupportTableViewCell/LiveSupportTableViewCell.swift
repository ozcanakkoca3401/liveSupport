//
//  LiveSupportTableViewCell.swift
//  LiveSupportModule
//
//  Created by Özcan AKKOCA on 29.01.2025.
//

import UIKit
import CoreExtension
import CoreResource

protocol LiveSupportTableViewCellDelegate: AnyObject {
    func didSelectOption(_ view: LiveSupportTableViewCell, index: Int)
}

final class LiveSupportTableViewCell: UITableViewCell {
    
    // MARK: - Views
    private let containerView: UIView = UIView()
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let leftSpacerView = UIView()
    
    private let iconImageContainerView = UIView()
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = CoreImages.LiveSupport.MessageItemIcon

        return imageView
    }()
    
    private lazy var messageSubItemView: LiveSupportSubItemView = {
        let messageSubItemView = LiveSupportSubItemView()
        messageSubItemView.delegate = self
        return messageSubItemView
    }()
    
    private let rightSpacerView = UIView()

    // MARK: - Properties
    weak var delegate: LiveSupportTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func prepare(with presentation: LiveSupportTableViewCellPresentation) {
        iconImageContainerView.isHidden = !presentation.isLeft
        leftSpacerView.isHidden = presentation.isLeft
        rightSpacerView.isHidden = !presentation.isLeft
        messageSubItemView.prepare(with: presentation.subItemPresentation)
    }
    
}

// MARK: - UI
private extension LiveSupportTableViewCell {
    func setupUI() {
        selectionStyle = .none
        layer.masksToBounds = true
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        
        contentView.addSubviewAndMakeConstraints(containerView, insets: .init(top: 8, left: 8, bottom: 8, right: 16))
        containerView.addSubviewAndMakeConstraints(containerStackView)
        
        containerStackView.addArrangedSubviews(leftSpacerView,
                                               iconImageContainerView,
                                               messageSubItemView,
                                               rightSpacerView)
        
        iconImageContainerView.addSubview(iconImageView)
        
        iconImageContainerView.snp.makeConstraints { make in
            make.width.equalTo(41)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(28)
            make.left.bottom.equalToSuperview()
        }
        
        messageSubItemView.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width * 0.63)
        }
    }
}

// MARK: - LiveSupportSubItemDelegate
extension LiveSupportTableViewCell: LiveSupportSubItemDelegate {
    func didSelectOption(_ view: LiveSupportSubItemView, index: Int) {
        DispatchQueue.main.async {
            self.delegate?.didSelectOption(self, index: index)
        }
    }
}
