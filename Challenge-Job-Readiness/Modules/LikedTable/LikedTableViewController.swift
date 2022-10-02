//
//  LikedTableViewController.swift
//  Challenge-Job-Readiness
//
//  Created by Alejandro Bruno Vola on 22/09/2022.
//

import UIKit

protocol LikedViewDelegate: AnyObject {
    func setProducts(_ products: [Product])
    func showError(_ errorMessage : String)
}

class LikedTableViewController: UIViewController {
    
    private let presenter: LikedPesenter
    
    private var items = [Product]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Components
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorColor = .andes_gray_100
        return tableView
    }()
    
    
    // MARK: - Init Controller
    init(presenter : LikedPesenter) {
        self.presenter = presenter
      
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        presenter.searchLikeds()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Private Methods
    
    private func setupView(){
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ProductsCell")
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "ProductTableViewCell")
        
        navigationItem.title = "Favoritos"
        
        let sizeConfig = UIImage.SymbolConfiguration(pointSize: 12.61, weight: .bold, scale: .large)
        
        view.addSubview(tableView)
    }
    
    @objc private func onCartBeenPressed() {
        print("Card has been pressed!")
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor,constant: 16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}
// MARK: - Extension SearchViewController
extension LikedTableViewController : LikedViewDelegate {
    
    func setProducts(_ products: [Product]) {
        self.items = products
    }
    
    func showError(_ errorMessage : String){
        let message = errorMessage
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - Extension TableView
extension LikedTableViewController: UITableViewDataSource, UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
        
        let model = items[indexPath.row]
        cell.configure(model: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = items[indexPath.row]
        
        let service = SearchService.shared
        let presenter = ProductDetailViewPresenter(service: service)
        let controller = ProductDetailViewController(productId: model.id, presenter: presenter)
        presenter.delegate = controller
        
        navigationController?.pushViewController(controller, animated: true)
    }
}
