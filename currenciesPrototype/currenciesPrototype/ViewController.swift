//
//  ViewController.swift
//  currenciesPrototype
//
//  Created by Daniel Bermudez on 6/17/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
     let apiClient = APIClient()
    override func viewDidLoad() {
        super.viewDidLoad()
        retrievData { (country, error) in
            print(country?[0].name ?? "=(")
        }
        
}
    
    private func retrievData (completion : @escaping ([CountryModel]?,Error?)->Void) {
        // Do any additional setup after loading the view.
        apiClient.retrieveCountries { [weak self] response in
            guard let strongSelf = self else {return}
            switch response {
            case .success(let countries):
                print(countries[0].name)
                completion(countries,nil)
            case .failure(let error) :
                switch error {
                case .authorizationError(let error), .clientError(let error), .connectionError(let error), .serverError(let error):
                    completion(nil, error)
                
                }
            }
            
        }
    }


}

