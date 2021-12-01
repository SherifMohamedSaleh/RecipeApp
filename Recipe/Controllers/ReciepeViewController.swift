//
//  ReciepeViewController.swift
//  Recipe
//
//  Created by Sherif Abd El-Moniem on 29/11/2021.
//

import UIKit
import ObjectMapper
import CoreData

class ReciepeViewController: BaseViewController ,UISearchBarDelegate {
    
    @IBOutlet weak var recipeTable: UITableView!
    @IBOutlet weak var searchTable: UITableView!
    
    private var  recipeRefreshControl = UIRefreshControl()
    
    let search = UISearchController(searchResultsController: nil)
    var wordsDataSource = [SearchTokens]()
    private var dataSource = [Hit]() {
        didSet {
            recipeTable.reloadData()
        }
    }
  override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = RecipeListViewPresenter.init(delegate: self)
        presenter?.viewIsReady()
        
        self.title = "Recipes"
        
        setupNavBar()
        setUpTableView()
    }
    
    func setUpTableView(){
        
        recipeTable.delegate = self
        recipeTable.dataSource = self
        
        searchTable.delegate = self
        searchTable.dataSource = self
        
        
        recipeTable.estimatedRowHeight = 150
        recipeTable.rowHeight = UITableView.automaticDimension
        recipeTable.separatorStyle = .none
        
        recipeRefreshControl.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
        
        recipeTable.refreshControl = recipeRefreshControl
        
        recipeTable.isHidden = true
        searchTable.isHidden = true
        
    }
    
    func setupNavBar() {
        
        navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = false
        
        search.searchBar.barTintColor = UIColor.white
        search.searchBar.tintColor = UIColor.white
        
        
        search.searchBar.delegate = self
        search.searchResultsUpdater = self
        search.automaticallyShowsScopeBar = false
        
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Find a recipe", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        
        search.searchBar.scopeButtonTitles = HealthLevel.allCases.map { $0.description }
        
        search.searchBar.searchTextField.textColor = UIColor.white
        search.searchBar.searchTextField.tokenBackgroundColor = UIColor.white
    }
    func showScopeBar(_ show: Bool) {
        guard search.searchBar.showsScopeBar != show else { return }
        search.searchBar.setShowsScope(show, animated: true)
        view.setNeedsLayout()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let search = searchBar.searchTextField.text else { return}
        (self.presenter as! RecipeListViewPresenter).userEditingSearchText(searchText: search)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchTable.isHidden = true
        if dataSource.count != 0 {
            recipeTable.isHidden = false
            self.hideNoDataView()
        }else {
            recipeTable.isHidden = true
            self.showNoDataView(message: "Welcome to recipe food App you can Search for any recipe ")
        }
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        self.hideNoDataView()
        searchTable.isHidden = false
        recipeTable.isHidden = true
        
        (self.presenter as! RecipeListViewPresenter).userDidBeginEditingSearchText()
    }
    @objc private func pullToRefresh (_ refreshControl: UIRefreshControl) {
        (self.presenter as! RecipeListViewPresenter).pullToRefresh()
    }
    
    
    @objc  private func loadMoreData () {
        (self.presenter as! RecipeListViewPresenter).loadMoreData()
    }
}

extension ReciepeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1 {
            return self.dataSource.count
        } else if tableView.tag == 2 {
            return wordsDataSource.count
        }
        return Int()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView.tag == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "recipe") as! RecipeTableViewCell
            cell.configure(item: self.dataSource[indexPath.row])
            return cell
        } else if tableView.tag == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Suggest", for: indexPath) as! SearchTableViewCell
            cell.word.text = wordsDataSource[wordsDataSource.count - indexPath.row - 1].word
            return cell
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.tag == 1 {
            let recipeDetailsViewControllervc = storyboard?.instantiateViewController(withIdentifier: "RecipeDetailsViewController") as! RecipeDetailsViewController

            recipeDetailsViewControllervc.hits = self.dataSource[indexPath.row]
            self.navigationController?.pushViewController(recipeDetailsViewControllervc, animated: true)
            
        } else if tableView.tag == 2 {
            
            let selectedText = wordsDataSource[wordsDataSource.count - indexPath.row - 1].word!
            
            (self.presenter as! RecipeListViewPresenter).deleteWord(index: wordsDataSource.count - indexPath.row - 1)
            
            (self.presenter as! RecipeListViewPresenter).saveSearchText(searchText: selectedText)
            
            (self.presenter as! RecipeListViewPresenter).geetRecipeList(searchText: selectedText, from: 0 , to: 10)
            
        }
    }
}

extension ReciepeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.searchTextField.isFirstResponder {
            searchController.showsSearchResultsController = true
            searchController.searchBar.searchTextField.backgroundColor = UIColor.cyan.withAlphaComponent(0.1)
        } else {
            searchController.searchBar.searchTextField.backgroundColor = nil
        }
    }
}

extension ReciepeViewController: RecipeListViewProtocol {
    func noMoreData() {    }
    func RecipeRetrieved(list: [Hit]) {
        self.search.isActive = false
        self.recipeTable.isHidden = false
        self.searchTable.isHidden = true
        self.dataSource = list
        self.showScopeBar(true)
        if list.count == 0 {
            self.showNoDataView(message: "Welcome to recipe food App you can Search for any recipe ")
        } else {
            self.hideNoDataView()
        }
    }
    func SearchRetrieved(list: [SearchTokens]) {
        self.wordsDataSource = list
        searchTable.reloadData()
        self.showScopeBar(false)
    }
}
