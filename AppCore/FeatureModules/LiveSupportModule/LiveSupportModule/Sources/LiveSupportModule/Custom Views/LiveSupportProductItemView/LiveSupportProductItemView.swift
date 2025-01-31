import UIKit
import CoreExtension
import CoreResource
import Kingfisher

protocol LiveSupportProductItemViewDelegate: AnyObject {
    func didSelectProduct(_ view: LiveSupportProductItemView)
}

final class LiveSupportProductItemView: UIView {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = CoreColors.border11.cgColor
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var statusContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = CoreColors.lightPurple11
        return view
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = CoreColors.purple11
        label.font = UIFont.regular(14, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    private let statusLineView: UIView = {
        let view = UIView()
        view.backgroundColor = CoreColors.border11
        return view
    }()
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 2
        return label
    }()
    
    private let orderNumberTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(12)
        label.textColor = .gray
        label.text = CoreLocalize.LiveSupport.OrderNumber
        return label
    }()

    private let orderNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(13)
        return label
    }()
    
    private let orderDateTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(12)
        label.textColor = .gray
        label.text = CoreLocalize.LiveSupport.Date
        return label
    }()
    
    private let orderDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(12)
        return label
    }()
    
    private lazy var selectButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(CoreColors.purple11, for: .normal)
        button.backgroundColor = .white
        button.setTitle(CoreLocalize.LiveSupport.Select, for: .normal)

        button.addTarget(self, action: #selector(selectButtonAction), for: .touchUpInside)
        button.titleLabel?.font = UIFont.regular(14)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = CoreColors.purple11.cgColor
        button.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        return button
    }()
    
    // MARK: - Properties
    weak var delegate: LiveSupportProductItemViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepare(with presentation: LiveSupportProductItemPresentation) {
        statusLabel.text = presentation.orderStatus
        productImageView.kf.setImage(with: presentation.imageUrl)
        orderNumberLabel.text = presentation.orderNumber
        orderDateLabel.text = presentation.orderDate
        titleLabel.text = presentation.title
    }
    
    private func setupUI() {
        addSubviewAndMakeConstraints(containerView)
        containerView.addSubview(statusContainerView)
        containerView.addSubview(stackView)
        
        statusContainerView.addSubviewAndMakeConstraints(statusLabel)
        statusContainerView.addSubview(statusLineView)
        
        statusContainerView.snp.makeConstraints { make in
            make.top.right.left.equalToSuperview()
            make.height.equalTo(30)
        }
        
        statusLineView.snp.makeConstraints { make in
            make.bottom.right.left.equalToSuperview()
            make.height.equalTo(1)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(statusContainerView.snp.bottom).inset(-8)
            make.bottom.left.right.equalToSuperview().inset(8)
        }
        
        stackView.addArrangedSubviews(productImageView,
                                      titleLabel,
                                      orderNumberTitleLabel,
                                      orderNumberLabel,
                                      orderDateTitleLabel,
                                      orderDateLabel,
                                      selectButton)
        
        productImageView.snp.makeConstraints { make in
            make.width.height.equalTo(120)
        }
        
        containerView.snp.makeConstraints { make in
            make.width.equalTo(136)
        }
    }
}

// MARK: Actions
private extension LiveSupportProductItemView {
    @objc func selectButtonAction() {
        delegate?.didSelectProduct(self)
    }
}
