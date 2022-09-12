//
//  InitialViewController.swift
//  Challenge-Job-Readiness
//
//  Created by Alejandro Bruno Vola on 12/09/2022.
//

import UIKit

class SearchViewController: UIViewController {

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
    
    private lazy var activityLabel: UILabel = {
        let aLabel = UILabel()
        aLabel.translatesAutoresizingMaskIntoConstraints = false
        aLabel.text = "Hola mundo"
        aLabel.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        aLabel.textAlignment = .center
        aLabel.numberOfLines = 0
        return aLabel
    }()
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupConstraints()
    }
    

    // MARK: - Navigation

     private func setupView(){
         // Agregar vistas a la vista principal del view controller
         self.view.addSubview(scrollView)
         scrollView.addSubview(contentView)
         contentView.addSubview(activityLabel)
         
         self.view.backgroundColor = UIColor(red: 218/255, green: 244/255, blue: 254/255, alpha: 1.00)

     }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            
            // ScrollView
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            //ContentView
            contentView.heightAnchor.constraint(equalToConstant: 600),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            
            // Title
            activityLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:70),
            activityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  16),
            activityLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -16),
            
            
            
        ])
    }

}
