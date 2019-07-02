//
//  ViewController.swift
//  currenciesPrototype
//
//  Created by Daniel Bermudez on 6/17/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    let countryViewModel =  CountryViewModel()
    @IBOutlet weak var originSearchField: UITextField!
    @IBOutlet weak var destinationSearchField: UITextField!
    
    
    var filteredCountries = [Country]()
    override func viewDidLoad() {
        super.viewDidLoad()
        countryViewModel.saveData()
        configureTextField()
    }
    private func configureTextField() {
        destinationSearchField.delegate = self
        originSearchField.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == originSearchField {
            performSegue(withIdentifier: "showOriginSearchView", sender: self)
        } else {
            performSegue(withIdentifier: "showDestinationSearchView", sender: self)
        }
    }
    
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(filteredCountries.count)
        return filteredCountries.count
    }
    
    
    
    func addResultsInTebleView() {
        
    }
    
}

