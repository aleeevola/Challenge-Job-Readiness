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
    
    private (set) var product : Product? {
        didSet{
            productCardView.product = product
        }
    }
    
    // MARK: Components
    
    lazy var productCardView: ProductCardView = {
        let aView = ProductCardView()
        aView.translatesAutoresizingMaskIntoConstraints = false
        aView.likeButton.addTarget(self, action: #selector(onLikeBeenPressed), for: .touchDown)
        return aView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        backgroundColor = .white
        selectionStyle = .none
        
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onBeenPressed)))
        
        addSubview(productCardView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            productCardView.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
            productCardView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 11),
            productCardView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -11),
            productCardView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -14),
        ])
    }
    
    
    @objc private func onBeenPressed() { onBeenSelected() }
    
    @objc private func onLikeBeenPressed(){
        SearchService.shared.likeProduct(id)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: Product) {
        id = model.id
        product = model
    }
    
}
