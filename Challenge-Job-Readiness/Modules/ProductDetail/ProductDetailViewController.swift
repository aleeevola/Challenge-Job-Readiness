//
//  ProductDetailViewController.swift
//  Challenge-Job-Readiness
//
//  Created by Alejandro Bruno Vola on 21/09/2022.
//

import UIKit

protocol ProductDetailViewDelegate : AnyObject {
    func setProduct(_ product : Product_detail) -> Void
}

class ProductDetailViewController: UIViewController {
    
    private var productId : String
    private var presenter: ProductDetailPresenter?
    
    private var product : Product_detail? {
        didSet{
            productDetail.product = product
        }
    }
    
    lazy var customNavigationBar: CustomNavigationBarView = {
        let view = CustomNavigationBarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backButton.addTarget(self, action: #selector(onBackBeenPress), for: .touchDown)
        view.likeButton.addTarget(self, action: #selector(onLikeBeenPress), for: .touchDown)
        return view
    }()
    
    lazy var productDetail: ProductDetailView = {
        let view = ProductDetailView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Init Controller
    init(productId : String, presenter: ProductDetailPresenter) {
        self.presenter = presenter
        self.productId = productId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        setupView()
        setupConstraints()
        
        self.presenter?.searchProduct(productId: self.productId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Private Methods
    @objc private func onBackBeenPress() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func onLikeBeenPress() {
        presenter?.likedTapped(productId)
    }
    
    private func setupView() {
        view.addSubview(customNavigationBar)
        view.addSubview(productDetail)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            customNavigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            customNavigationBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            customNavigationBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            productDetail.topAnchor.constraint(equalTo: customNavigationBar.bottomAnchor),
            productDetail.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            productDetail.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -16),
            productDetail.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ProductDetailViewController : ProductDetailViewDelegate {
    func setProduct(_ product : Product_detail) {
        self.product = product
    }
}
