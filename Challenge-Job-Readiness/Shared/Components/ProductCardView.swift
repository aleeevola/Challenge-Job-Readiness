//
//  ProductCardView.swift
//  Challenge-Job-Readiness
//
//  Created by Alejandro Bruno Vola on 22/09/2022.
//

import Foundation
import UIKit

class ProductCardView : UIView {
    
    // MARK: Components
    var product : Product? {
        didSet{
            if let product = product {
                titleLabel.text = product.name
                priceLabel.text = String(product.price).currencyFormatting()
                locationLabel.text = product.location
                productImageView.load(url: URL(string: product.imageUrl)!)
            }
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let aLabel = UILabel()
        aLabel.translatesAutoresizingMaskIntoConstraints = false
        aLabel.font = UIFont.systemFont(ofSize: 13)
        aLabel.textAlignment = .left
        return aLabel
    }()
    
    private lazy var priceLabel: UILabel = {
        let aLabel = UILabel()
        aLabel.translatesAutoresizingMaskIntoConstraints = false
        aLabel.font = UIFont.systemFont(ofSize: 20)
        aLabel.textAlignment = .left
        return aLabel
    }()
    
    private lazy var detailLabel: UILabel = {
        let aLabel = UILabel()
        aLabel.translatesAutoresizingMaskIntoConstraints = false
        aLabel.font = UIFont.systemFont(ofSize: 11)
        aLabel.textAlignment = .left
        return aLabel
    }()
    
    private lazy var locationLabel: UILabel = {
        let aLabel = UILabel()
        aLabel.translatesAutoresizingMaskIntoConstraints = false
        aLabel.font = UIFont.systemFont(ofSize: 11)
        aLabel.textAlignment = .left
        return aLabel
    }()
    
    private lazy var stackView: UIStackView = {
        let aStackView = UIStackView()
        aStackView.addArrangedSubview(titleLabel)
        aStackView.addArrangedSubview(priceLabel)
        aStackView.addArrangedSubview(detailLabel)
        aStackView.addArrangedSubview(locationLabel)
        aStackView.axis = .vertical
        aStackView.translatesAutoresizingMaskIntoConstraints = false
        aStackView.spacing = 4
        return aStackView
    }()
    
    private lazy var imageContainer: UIView = {
        let aView = UIView()
        aView.translatesAutoresizingMaskIntoConstraints = false
        aView.addSubview(productImageView)
        aView.addSubview(likeButton)
        aView.clipsToBounds = true
        aView.layer.cornerRadius = 4
        return aView
    }()
    
    
    private lazy var productImageView: UIImageView = {
        let aImageView = UIImageView()
        aImageView.backgroundColor = .gray
        aImageView.clipsToBounds = true
        aImageView.translatesAutoresizingMaskIntoConstraints = false
        return aImageView
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white.withAlphaComponent(0.9)
        button.layer.cornerRadius = 14.5
        
        let sizeConfig = UIImage.SymbolConfiguration(pointSize: 12.61, weight: .bold, scale: .large)
        button.setImage(UIImage(named: "like-icon")?.withConfiguration(sizeConfig), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: Method's override
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Build view
    private func setupView (){
        self.addSubview(imageContainer)
        self.addSubview(stackView)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            imageContainer.topAnchor.constraint(equalTo: self.topAnchor),
            imageContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageContainer.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor),
            
            productImageView.topAnchor.constraint(equalTo: imageContainer.topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: imageContainer.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor),
            productImageView.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 131),
            productImageView.heightAnchor.constraint(equalToConstant: 131),
            
            likeButton.topAnchor.constraint(equalTo: imageContainer.topAnchor, constant: 6),
            likeButton.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor, constant: -6),
            likeButton.widthAnchor.constraint(equalToConstant: 29),
            likeButton.widthAnchor.constraint(equalTo: likeButton.heightAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: imageContainer.trailingAnchor, constant: 10),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor)
        ])
    }
}
