//
//  CountriesLoader.swift
//  currenciesPrototype
//
//  Created by Daniel Bermudez on 6/20/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import Foundation
import CoreData

class CountriesLoader {
    private let apiClient = APIClient()
    private let localStorage = LocalStorage()
    
    private var currencies = [Currency]()
    
    
    func testCoreData () {
        retrieveData { (country, error) in
//            self.saveFrom(currency: (country?[0].currencies[0])!)
            self.loadCurrencies()
        }
    }
    
    
    private func retrieveData (completion : @escaping ([CountryModel]?,Error?)->Void) {
        // Do any additional setup after loading the view.
        apiClient.retrieveCountries { [weak self] response in
            guard let strongSelf = self else {return}
            switch response {
            case .success(let countries):
               
                completion(countries,nil)
            case .failure(let error) :
                switch error {
                case .authorizationError(let error), .clientError(let error), .connectionError(let error), .serverError(let error):
                    completion(nil, error)
                    
                }
            }
            
        }
    }
    private func loadCurrencies(){
       let context = localStorage.persistentContainer.viewContext
        do {
          currencies = try context.fetch(Currency.fetchRequest())
            print(currencies[0].name)
        } catch let error as NSError {
            print("Could Not Fetch Currency")
        }
    }
    private func saveFrom(currency : CurrencyModel) {
        let context = localStorage.persistentContainer.viewContext
        let currencyEntity = Currency (entity: Currency.entity(), insertInto: context)
        currencyEntity.name = currency.name
        currencyEntity.code = currency.name
        currencyEntity.symbol = currency.symbol
        localStorage.saveContext()
        
    }
    
}

