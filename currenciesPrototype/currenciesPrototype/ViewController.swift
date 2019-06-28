//
//  ViewController.swift
//  currenciesPrototype
//
//  Created by Daniel Bermudez on 6/17/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    
    let countryViewModel =  CountryViewModel()
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var resultTableView: UITableView!
    
    var filteredCountries = [Country]()
    override func viewDidLoad() {
        super.viewDidLoad()
        countryViewModel.saveData()
        configureTextField()
    }
    private func configureTextField() {
        searchField.addTarget(self, action: #selector(printSearchedCountries), for: .allEditingEvents)
    }
    
    
    
    @objc func printSearchedCountries() {
        
        if let countryName = searchField.text, !countryName.isEmpty {
            filteredCountries = countryViewModel.filtercontries(countryName: countryName)
            resultTableView.reloadData()
//            for result in filteredCountries {
//
//                print(result.name ?? "no name found")
//            }
//            print(filteredCountries.count)
        }else {
            filteredCountries = []
            
            resultTableView.reloadData()
        }
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Results"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(filteredCountries.count)
        return filteredCountries.count
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for:  indexPath)
        cell.textLabel?.text = filteredCountries[indexPath.row].name
        return cell
    }
}

