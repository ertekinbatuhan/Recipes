//
//  ViewController.swift
//  Recipes
//
//  Created by Batuhan Berk Ertekin on 26.08.2024.
//

import UIKit

class HomeViewController: UIViewController, RecipeViewModelDelegate {
    
    private let viewModel: RecipeViewModel
    private var recipes: [RecipeResult] = []
    private let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let searchController = UISearchController(searchResultsController: nil)
    private var isLoading = false 
    
    init(viewModel: RecipeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        showLoadingIndicator()
        viewModel.fetchRecipes(query: "")
        setupUI()
    }
    
    private func setupUI() {
        setupSearchController()
        setupTableView()
        setupDelegates()
        setupNavigationBar()
        setupActivityIndicator()
        tableView.register(RecipeCell.self, forCellReuseIdentifier: RecipeCell.identifier)
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Recipes"
    }
    
    private func setupSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func showLoadingIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
            self.activityIndicator.isHidden = false
        }
    }
    
    private func hideLoadingIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }
    
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        searchController.searchBar.delegate = self
    }
    
    func updateRecipeListView(with recipes: [RecipeResult]) {
        self.recipes.append(contentsOf: recipes)
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.hideLoadingIndicator()
            self.isLoading = false
        }
    }
    
    private func loadMoreRecipesIfNeeded(currentIndexPath: IndexPath) {
        let lastItemIndex = recipes.count - 1
        if currentIndexPath.row == lastItemIndex && !isLoading {
            isLoading = true
            let query = searchController.searchBar.text ?? ""
            viewModel.loadMoreRecipes(query: query)
        }
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let query = searchText.isEmpty ? "" : searchText
        self.recipes.removeAll()
        self.tableView.reloadData()
        viewModel.fetchRecipes(query: query)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeCell.identifier, for: indexPath) as! RecipeCell
        let recipe = recipes[indexPath.row]
        cell.configure(with: recipe)
        loadMoreRecipesIfNeeded(currentIndexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
