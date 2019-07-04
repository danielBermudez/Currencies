//
//  ExpenseViewController.swift
//  currenciesPrototype
//
//  Created by Daniel Bermudez on 7/4/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import UIKit

class ExpenseViewController: UIViewController {
    
    private var availableCurrencies = [Currency]()
    @IBOutlet weak var pickerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var currencyTextField: UITextField!
    @IBOutlet weak var currencyField: UITextField!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    let expenseViewModel = ExpenseViewModel()
    
    @IBOutlet weak var currencyRateStackView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()        
        dismissKey()
        configuringTargets()
        hidePickerView()
        configuretextFieldDelegate()
        configurePickerviewDelegate()
    }
    
    private func configuringTargets() {
        currencyTextField.addTarget(self, action: #selector(showPickerView), for: .editingDidBegin)
    }
    private func configuretextFieldDelegate() {
        currencyTextField.delegate = self
    }
    
    private func configurePickerviewDelegate() {
        currencyPicker.delegate = self
    }
    
    @objc private func hidePickerView() {
        pickerHeightConstraint.constant = 0
    }
    
    @objc private func showPickerView() {
        pickerHeightConstraint.constant = 216
    }
    
    private func shouldHideCurrencyRate(){
        if let currencyCode = currencyField.text {
            if expenseViewModel.currencyRatefieldIsNeeded(currencyCode: currencyCode) {
                currencyRateStackView.isHidden = true
            } else {
                currencyRateStackView.isHidden = false
            }
        }
    }
    
    private func updateAvailableCurrencies() {
        availableCurrencies = expenseViewModel.listAvaiableCurrencies()
        currencyPicker.reloadAllComponents()
    }
    
}
extension ExpenseViewController :UIPickerViewDelegate, UIPickerViewDataSource {
    
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
        shouldHideCurrencyRate()
    }
}
extension ExpenseViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {        
            updateAvailableCurrencies()
        }
    }

