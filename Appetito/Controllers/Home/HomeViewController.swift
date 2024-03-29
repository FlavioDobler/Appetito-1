//
//  HomeViewController.swift
//  Appetito
//
//  Created by Gustavo Fernandes on 29/08/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let homeView: HomeView = {
        let homeView = HomeView()
        homeView.translatesAutoresizingMaskIntoConstraints = false
        
        return homeView
    }()
    
    lazy var categoryCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor(named: "mainBackground")
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCollectionViewCell")
        
        return collection
    }()
    
    private let searchBar: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.placeholder = "Procure um restaurante"
        
        return search
    }()
    
    lazy var carouselCollectionView : UICollectionView = {
        let carouselCollectionView = UICollectionViewFlowLayout()
        carouselCollectionView.scrollDirection = .horizontal
        let carouselFlowCollectionView = UICollectionView(frame: .zero, collectionViewLayout: carouselCollectionView)
        carouselFlowCollectionView.backgroundColor = UIColor(named: "mainBackground")
        carouselFlowCollectionView.translatesAutoresizingMaskIntoConstraints = false
        carouselFlowCollectionView.register(CarouselCollectionViewCell.self, forCellWithReuseIdentifier: "CarouselCollectionViewCell")
        return carouselFlowCollectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        carouselCollectionView.delegate = self
        carouselCollectionView.dataSource = self
        self.view.backgroundColor = UIColor(named: "mainBackground")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
extension HomeViewController: ViewConfiguration {
    func buildViewHierarchy() {
        view.addSubview(homeView)
        view.addSubview(categoryCollectionView)
        view.addSubview(carouselCollectionView)
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            
            homeView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            homeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            homeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            homeView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
            carouselCollectionView.topAnchor.constraint(equalTo: homeView.topAnchor, constant: 140),
            carouselCollectionView.leadingAnchor.constraint(equalTo: homeView.leadingAnchor, constant: 0),
            carouselCollectionView.trailingAnchor.constraint(equalTo: homeView.trailingAnchor, constant: 0),
            carouselCollectionView.heightAnchor.constraint(equalToConstant: 25),
            
            categoryCollectionView.topAnchor.constraint(equalTo: carouselCollectionView.bottomAnchor, constant: 10),
            categoryCollectionView.leadingAnchor.constraint(equalTo: homeView.leadingAnchor, constant: 10),
            categoryCollectionView.trailingAnchor.constraint(equalTo: homeView.trailingAnchor, constant: -10),
            categoryCollectionView.bottomAnchor.constraint(equalTo: homeView.bottomAnchor, constant: 0)
        ])
    }
    func setupAdditionalConfiguration() {
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sair", style: .plain, target: self, action: #selector(didTapSignOut))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "mainYellow")
        self.navigationItem.searchController = searchBar
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.categoryCollectionView {
            return 20
        }
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.categoryCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as? CustomCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        } else {
            guard let carouCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCollectionViewCell", for: indexPath) as? CarouselCollectionViewCell else {
                return UICollectionViewCell()
            }
            return carouCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.categoryCollectionView {
            print("index path: \(indexPath)")
            
            let infosViewController = InfosViewController()
            let navigationController = UINavigationController(rootViewController: infosViewController)
            
            self.present(navigationController, animated: true)
        }
    }
    
    @objc func didTapSignOut() {
            //TODO: Implementar SignOut firebase
            let initialViewController = InitialViewController()
            let navigationController = UINavigationController(rootViewController: initialViewController)
            navigationController.modalPresentationStyle = .fullScreen
            self.show(navigationController, sender: self)
        }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.categoryCollectionView{
            return CGSize(width: 165, height: 200)
            
        }
        return CGSize(width: 150, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 8, right: 8)
    }
}

