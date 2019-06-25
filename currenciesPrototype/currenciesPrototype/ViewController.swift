//
//  ViewController.swift
//  currenciesPrototype
//
//  Created by Daniel Bermudez on 6/17/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var originTextField: UITextField!
    @IBOutlet weak var destinationTextField: UITextField!
    
    let countriesLoad =  CountriesLoader()
    lazy var countries = countriesLoad.countries
    var filtered = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countriesLoad.testCoreData()
        
        originTextField.addTarget(self, action: #selector(filterCountries), for: .editingChanged)
        destinationTextField.addTarget(self, action: #selector(filterCountries), for: .editingChanged)
        
        self.dismissKey()
    }
    
    @objc func filterCountries(){
        
    }
}

//MARK: - Hide Keyboard
extension UIViewController {
    
    func dismissKey() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
