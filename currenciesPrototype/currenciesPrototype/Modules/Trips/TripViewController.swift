//
//  ViewController.swift
//  currenciesPrototype
//
//  Created by Daniel Bermudez on 6/17/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import UIKit

class TripViewController: UIViewController, UITextFieldDelegate {
    
    
    private let tripViewModel = TripViewModel()
    private let countryViewModel =  CountryViewModel()
    private var availableCurrencies = [Currency]()
    @IBOutlet weak private var originSearchField: UITextField!
    @IBOutlet weak private var destinationSearchField: UITextField!
    @IBOutlet weak private var amountField: UITextField!
    @IBOutlet weak private var currencyField: UITextField!
    @IBOutlet weak private var currencyPicker: UIPickerView!
    @IBOutlet weak private var currencyRate: UITextField!
    @IBOutlet weak private var CurrencyRateHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var pickerConstraint: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryViewModel.saveData()
        configureTextField()
        configurePickerView()
        configureTextFieldTargets()
        hidePickerView()
        dismissKey()   
        addDoneButton()
        
    }
    
    func addDoneButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDoneButton))
    }
    private func configureTextField() {
        destinationSearchField.delegate = self
        originSearchField.delegate = self
        currencyField.delegate = self
        
    }
    
    private func configureTextFieldTargets(){
        currencyField.addTarget(self, action: #selector(showPickerView), for: .editingDidBegin)
        currencyField.addTarget(self, action: #selector(hidePickerView), for: .editingDidEnd)
    }
    
    private func configurePickerView() {
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
    }
    
    @objc private func showPickerView(){
        pickerConstraint.constant = 216
    }
    
    @objc private func hidePickerView(){
        pickerConstraint.constant = 0
    }
    
   
    @objc private func didTapDoneButton() {
        
    }
    
     func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == originSearchField {
            performSegue(withIdentifier: "showOriginSearchView", sender: self)
        } else if textField == destinationSearchField{
            performSegue(withIdentifier: "showDestinationSearchView", sender: self)
        } else {
            updateAvailableCurrencies()
        }
    }
    
    private func updateAvailableCurrencies() {
        availableCurrencies = tripViewModel.listAvaiableCurrencies()
        currencyPicker.reloadAllComponents()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showOriginSearchView" {
            let navigationController = segue.destination as? UINavigationController
            if let countrySearchViewController = navigationController?.viewControllers.first as? CountrySearchViewController {
                countrySearchViewController.countryType = .origin
                countrySearchViewController.countryselectionDelegate = self
            }
        } else if segue.identifier == "showDestinationSearchView" {
            let navigationController = segue.destination as? UINavigationController
            if let countrySearchViewController = navigationController?.viewControllers.first as? CountrySearchViewController {
                countrySearchViewController.countryType = .destination
                countrySearchViewController.countryselectionDelegate = self
            }
        }
    }
}

extension TripViewController :UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return availableCurrencies.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return availableCurrencies[row].code
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currencyField.text = availableCurrencies[row].code
        
    }
    
    
    
}

extension TripViewController : CountrySelectionDelegate {
    func countryHasBeenSelected(country: Country, countryType: CountryType) {
        tripViewModel.assignCountry(country: country, countryType: countryType)
        if countryType == .origin {
            originSearchField.text = country.name
        } else {
            destinationSearchField.text = country.name
        }
        let currencies = tripViewModel.listAvaiableCurrencies()
        for currency in currencies {
            print(currency.name)
        }
    }
}

//MARK: - Keyboard Settings

extension UIViewController {
    func dismissKey()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}
