//
//  InitialViewController.swift
//  Challenge-Job-Readiness
//
//  Created by Alejandro Bruno Vola on 12/09/2022.
//

import UIKit


protocol SearchViewDelegate: AnyObject {
    func setProducts(_ products: [Product])
    func showError(_ errorMessage : String)
}


class SearchViewController: UIViewController {
    
    private let presenter: SearchPesenter
    
    private var items : [Product] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Components
    lazy var totalResultLabel: UILabel = {
        let aLabel = UILabel()
        aLabel.translatesAutoresizingMaskIntoConstraints = false
        aLabel.text = "\(items.count) resultados"
        aLabel.font = UIFont.systemFont(ofSize: 14)
        aLabel.textColor = .grey4
        aLabel.textAlignment = .left
        return aLabel
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorColor = .andes_gray_100
        return tableView
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Buscar en Mercado Libre"
        return searchBar
    }()
    
    // MARK: - Init Controller
    
    init(presenter : SearchPesenter){
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
        
        //view.addSubview(totalResultLabel)
        view.addSubview(tableView)
        
        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "cart-icon"), style: .done, target: self, action: #selector(onCartBeenPressed))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu-icon"),  style: .done, target: self, action: #selector(onCartBeenPressed))
        navigationItem.rightBarButtonItem?.tintColor = .black
        navigationItem.leftBarButtonItem?.tintColor = .black

    }
    
    @objc private func onCartBeenPressed() {
        print("Card has been pressed!")
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
//            totalResultLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
//            totalResultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            totalResultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            totalResultLabel.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor,constant: 16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
}
// MARK: - Extension SearchViewController
extension SearchViewController : SearchViewDelegate {
    
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
extension SearchViewController: UITableViewDataSource, UITableViewDelegate  {
    
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

// MARK: - Extension UISearchBar
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text!.isEmpty == false {
            self.presenter.searchProducts(searchBar.text!)
        }
    }
}
