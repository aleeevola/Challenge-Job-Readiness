//
//  ProductDetail.swift
//  Challenge-Job-Readiness
//
//  Created by Alejandro Bruno Vola on 21/09/2022.
//

import Foundation
import UIKit

class ProductDetailView : UIView {
    
    // MARK: Components
    
    var product : Product_detail? {
        didSet{
            if let product = product {
                nameLabel.text = product.name
                productImageView.load(url: URL(string: product.imageUrl)!)
                priceLabel.text = String(product.price).currencyFormatting()
                descriptionContainerLabel.text = product.details
            }
        }
    }
    
    private lazy var scrollView: UIScrollView = {
            let aScrollView = UIScrollView()
            aScrollView.translatesAutoresizingMaskIntoConstraints = false
            return aScrollView
        }()
    
    private lazy var contentView: UIView = {
            let aView = UIView()
            aView.translatesAutoresizingMaskIntoConstraints = false
            return aView
        }()
    
    private lazy var nameLabel: UILabel = {
        let aLabel = UILabel()
        aLabel.translatesAutoresizingMaskIntoConstraints = false
        aLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        aLabel.numberOfLines = 0
        aLabel.textAlignment = .left
        return aLabel
    }()
    
    private lazy var imageContainer: UIView = {
        let aView = UIView()
        aView.translatesAutoresizingMaskIntoConstraints = false
        aView.addSubview(productImageView)
        return aView
    }()
    
    private lazy var productImageView: UIImageView = {
        let aImageView = UIImageView()
        aImageView.backgroundColor = .gray
        aImageView.clipsToBounds = true
        aImageView.translatesAutoresizingMaskIntoConstraints = false
        return aImageView
    }()
    
    private lazy var priceLabel: UILabel = {
        let aLabel = UILabel()
        aLabel.translatesAutoresizingMaskIntoConstraints = false
        aLabel.font = UIFont.systemFont(ofSize: 36, weight: .semibold)

        aLabel.textAlignment = .left
        return aLabel
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let aLabel = UILabel()
        aLabel.translatesAutoresizingMaskIntoConstraints = false
        aLabel.font = UIFont.systemFont(ofSize: 16)
        aLabel.text =  "Descripción"
        aLabel.textAlignment = .left
        return aLabel
    }()
    
    private lazy var descriptionContainerLabel: UILabel = {
        let aLabel = UILabel()
        aLabel.translatesAutoresizingMaskIntoConstraints = false
        aLabel.font = UIFont.systemFont(ofSize: 16)
        aLabel.textAlignment = .left
        aLabel.numberOfLines = 0
        return aLabel
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
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(imageContainer)
        contentView.addSubview(priceLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(descriptionContainerLabel)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([

            // ScrollView
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            
            //ContentView
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 34),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            imageContainer.topAnchor.constraint(equalTo: nameLabel.topAnchor,constant: 46),
            imageContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageContainer.heightAnchor.constraint(equalTo: imageContainer.widthAnchor),
            
            productImageView.topAnchor.constraint(equalTo: imageContainer.topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: imageContainer.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor),
            productImageView.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor,constant: 24),
            
            descriptionLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 24),
            
            descriptionContainerLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
            descriptionContainerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            descriptionContainerLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            descriptionContainerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }
}
