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
    
    private var viewModel: SearchViewModel?
    
    private var items : [Product] = []
    
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
//        searchBar.tintColor = .andes_brand
//        searchBar.backgroundColor = .andes_brand
        return searchBar
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
        setupView()
        setupConstraints()
    }
    
    
    // MARK: - Private Methods
    
    private func setupViewModel(){
        self.viewModel = SearchViewModel(service: SearchService.shared, delegate: self)
    }
    
    private func setupView(){
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ProductsCell")
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "ProductTableViewCell")
        
        //view.addSubview(totalResultLabel)
        view.addSubview(tableView)
        
        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Cart"), style: .done, target: self, action: #selector(onCartBeenPressed))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"),  style: .done, target: self, action: #selector(onCartBeenPressed))
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
        self.tableView.reloadData()
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
        print("CELL: \(model)")
    }
}

// MARK: - Extension UISearchBar
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text!.isEmpty == false {
            self.viewModel?.searchProducts(searchBar.text!)
        }
    }
}
