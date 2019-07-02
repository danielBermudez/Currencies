//
//  SearchTableViewController.swift
//  currenciesPrototype
//
//  Created by Daniel Bermudez on 7/2/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {
    let countryViewModel = CountryViewModel()
    let searchController = UISearchController(searchResultsController: nil)
    var countryType = CountryType?()
    var filteredCountries = [Country]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
    }
    override func viewDidAppear(_ animated: Bool) {
        searchController.isActive = true
        
        searchController.becomeFirstResponder()
    }
    
    
    // MARK: - Configuration
    
    func configureNavigationBar(){
        navigationItem.title = "Country"
        configureSearchController()
        addCancelButton()
    }
    
    func configureSearchController(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Country"
        navigationItem.hidesSearchBarWhenScrolling = false
        
      
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func addCancelButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissView))
    }
    
    
    
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredCountries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for:  indexPath)
        cell.textLabel?.text = filteredCountries[indexPath.row].name
        return cell
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filteredContentForSearchText(searchText :String){
        filteredCountries = countryViewModel.filtercontries(countryName: searchText)
        tableView.reloadData()
    }
    
    
    
}

extension SearchTableViewController : UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filteredContentForSearchText(searchText: searchController.searchBar.text!)
    }
    
    
}
