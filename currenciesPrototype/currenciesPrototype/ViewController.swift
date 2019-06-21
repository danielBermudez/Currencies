//
//  ViewController.swift
//  currenciesPrototype
//
//  Created by Daniel Bermudez on 6/17/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
     let countriesLoad =  CountryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       countriesLoad.testCoreData()
        
}
    


}

