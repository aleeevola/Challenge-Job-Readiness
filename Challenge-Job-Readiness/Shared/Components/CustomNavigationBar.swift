//
//  CustomNavigationBar.swift
//  Challenge-Job-Readiness
//
//  Created by Alejandro Bruno Vola on 21/09/2022.
//

import Foundation
import UIKit

class CustomNavigationBar : UIView {
    
    // MARK: Components
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        
        let sizeConfig = UIImage.SymbolConfiguration(pointSize: 12.61, weight: .bold, scale: .large)
        button.setImage(UIImage(systemName: "arrow.backward")?.withTintColor(.black, renderingMode: .alwaysOriginal).withConfiguration(sizeConfig), for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
        
        let sizeConfig = UIImage.SymbolConfiguration(pointSize: 21, weight: .bold, scale: .large)
        button.setImage(UIImage(named: "like-icon")?.withTintColor(.black, renderingMode: .alwaysOriginal).withConfiguration(sizeConfig), for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        
        let sizeConfig = UIImage.SymbolConfiguration(pointSize: 21, weight: .bold, scale: .large)
        button.setImage(UIImage(named: "search-icon")?.withTintColor(.black, renderingMode: .alwaysOriginal).withConfiguration(sizeConfig), for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var cartButton: UIButton = {
        let button = UIButton()
        
        let sizeConfig = UIImage.SymbolConfiguration(pointSize: 21, weight: .bold, scale: .large)
        button.setImage(UIImage(named: "cart-icon")?.withTintColor(.black, renderingMode: .alwaysOriginal).withConfiguration(sizeConfig), for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var locationLabel: UILabel = {
        let attributedString = NSMutableAttributedString(string: "")
        let locationAttachment = NSTextAttachment()
        locationAttachment.image = UIImage(named: "location-icon")
        locationAttachment.bounds = CGRect(x: 0, y: -1.56, width: 10.81, height: 15.56)
        attributedString.append((NSAttributedString(attachment: locationAttachment)))
        attributedString.append(NSAttributedString(string: " Enviar a Nombre de Usuario - Dirección "))
        
        let arrowAttachment = NSTextAttachment()
        arrowAttachment.image = UIImage(named: "arrow-icon")
        arrowAttachment.bounds = CGRect(x: 0, y: 0, width: 4.94, height: 8.3)
        attributedString.append((NSAttributedString(attachment: arrowAttachment)))
        
        let aLabel = UILabel()
        aLabel.translatesAutoresizingMaskIntoConstraints = false
        aLabel.font = UIFont.systemFont(ofSize: 14)
        aLabel.attributedText = attributedString
        aLabel.textAlignment = .left
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
        self.backgroundColor = .andes_brand
        
        self.addSubview(backButton)
        self.addSubview(locationLabel)
        self.addSubview(cartButton)
        self.addSubview(searchButton)
        self.addSubview(likeButton)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 82),
            
            backButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 17.5),
            
            locationLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -10),
            locationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 17.5),
            
            cartButton.topAnchor.constraint(equalTo: self.topAnchor,constant: 15),
            cartButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -17.5),
            
            searchButton.topAnchor.constraint(equalTo: cartButton.topAnchor),
            searchButton.trailingAnchor.constraint(equalTo: cartButton.leadingAnchor,constant: -17.5),
            
            likeButton.topAnchor.constraint(equalTo: searchButton.topAnchor),
            likeButton.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor,constant: -17.5),
        ])
    }
}

