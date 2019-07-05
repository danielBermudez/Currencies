//
//  SearchTableViewController.swift
//  currenciesPrototype
//
//  Created by Daniel Bermudez on 7/2/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import UIKit

protocol CountrySelectionDelegate {
    func countryHasBeenSelected(country : Country, countryType: CountryType)
}

class CountrySearchViewController: UITableViewController,UISearchControllerDelegate, UISearchBarDelegate {
    
    // MARK: - Stored Properties

    let countryViewModel = CountryViewModel()
    var mySearchController = UISearchController()
    let searchController = UISearchController(searchResultsController: nil)
    var countryselectionDelegate : CountrySelectionDelegate?
    var countryType : CountryType!
    var filteredCountries = [Country]()
    
     // MARK: - LifeCicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.delegate = self
        configureNavigationBar()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        searchController.isActive = true
    }
    
    // MARK: - Configuration
    
    func configureNavigationBar() {
        navigationItem.title = "Country"
        configureSearchController()
        addCancelButton()
    }
    
    func configureSearchController() {
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
    
    func presentSearchController(_ searchController: UISearchController) {
        searchController.searchBar.becomeFirstResponder()
    }
    
    // MARK: - Actions
    
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func filteredCountriesForSearchText(searchText :String){
        filteredCountries = countryViewModel.filtercontries(countryName: searchText)
        tableView.reloadData()
    }
    
    // MARK: - Table view
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCountries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for:  indexPath)
        cell.textLabel?.text = filteredCountries[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = countryselectionDelegate {
                delegate.countryHasBeenSelected(country: filteredCountries[indexPath.row], countryType: countryType)
        }
        dismissView()
    }
    
}

extension CountrySearchViewController : UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filteredCountriesForSearchText(searchText: searchController.searchBar.text!)
    }
}
