//
//  ProductTableViewCell.swift
//  Challenge-Job-Readiness
//
//  Created by Alejandro Bruno Vola on 16/09/2022.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    // MARK: - Attributes
    var onBeenSelected: (() -> Void) = {}
    
    private var id : String = ""

    private lazy var cardView: UIView = {
        let aView = UIView()
        aView.translatesAutoresizingMaskIntoConstraints = false
        return aView
    }()
    
    lazy var titleLabel: UILabel = {
        let aLabel = UILabel()
        aLabel.translatesAutoresizingMaskIntoConstraints = false
        aLabel.font = UIFont.systemFont(ofSize: 13)
        aLabel.textAlignment = .left
        return aLabel
    }()
    
    lazy var priceLabel: UILabel = {
        let aLabel = UILabel()
        aLabel.translatesAutoresizingMaskIntoConstraints = false
        aLabel.font = UIFont.systemFont(ofSize: 20)
        aLabel.textAlignment = .left
        return aLabel
    }()
    
    lazy var detailLabel: UILabel = {
        let aLabel = UILabel()
        aLabel.translatesAutoresizingMaskIntoConstraints = false
        aLabel.font = UIFont.systemFont(ofSize: 11)
        aLabel.textAlignment = .left
        return aLabel
    }()
    
    lazy var locationLabel: UILabel = {
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
        //let image = UIImage(named: "logo")
        //aImageView.image = image
        return aImageView
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white.withAlphaComponent(0.9)
        button.layer.cornerRadius = 14.5
        
        let sizeConfig = UIImage.SymbolConfiguration(pointSize: 12.61, weight: .bold, scale: .large)
        button.setImage(UIImage(named: "like-icon")?.withConfiguration(sizeConfig), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        backgroundColor = .white
        selectionStyle = .none
        
        likeButton.addTarget(self, action: #selector(onLikeBeenPressed), for: .touchDown)
        
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onBeenPressed)))
        
        addSubview(cardView)
        cardView.addSubview(imageContainer)
        cardView.addSubview(stackView)
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            cardView.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
            cardView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 11),
            cardView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -11),
            cardView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -14),
            
            imageContainer.topAnchor.constraint(equalTo: cardView.topAnchor),
            imageContainer.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            imageContainer.bottomAnchor.constraint(lessThanOrEqualTo: cardView.bottomAnchor),
            
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
            stackView.topAnchor.constraint(equalTo: cardView.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: cardView.bottomAnchor)
            
        ])
    }
    
    
    @objc private func onBeenPressed() { onBeenSelected() }
    
    @objc private func onLikeBeenPressed(){
        print("like this")
        SearchService.shared.likeProduct(id)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: Product) {
        id = model.id
        titleLabel.text = model.name
        detailLabel.text = model.extraDetails
        priceLabel.text = String(model.price).currencyFormatting()
        locationLabel.text = model.location
        productImageView.load(url: URL(string: model.imageUrl)!)
    }
    
}
