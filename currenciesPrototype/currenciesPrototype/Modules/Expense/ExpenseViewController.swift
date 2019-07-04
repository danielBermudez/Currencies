//
//  ExpenseViewController.swift
//  currenciesPrototype
//
//  Created by Daniel Bermudez on 7/4/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import UIKit

class ExpenseViewController: UIViewController {

    @IBOutlet weak var pickerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var currencyTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dismissKey()
        configuringTargets()
        hidePickerView()
    }
    
    private func configuringTargets() {
        currencyTextField.addTarget(self, action: #selector(showPickerView), for: .editingDidBegin)
    }
    
    @objc private func hidePickerView() {
        pickerHeightConstraint.constant = 0
    }
    
    @objc private func showPickerView() {
        pickerHeightConstraint.constant = 216
    }
    
}
