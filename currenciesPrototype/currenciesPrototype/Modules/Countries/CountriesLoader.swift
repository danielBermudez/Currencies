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
    private var countries = [Country]()
    
    func testCoreData () {
        retrieveData { (countries, error) in
            if let countries = countries {
            for country in countries {
                self.saveFrom(countryModel: country)
            }
            self.loadCountries()
            print(countries.count)
        }
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
    
    private func saveFrom(countryModel : CountryModel) {
        let context = localStorage.persistentContainer.viewContext
        let countryEntity = Country (entity: Country.entity(), insertInto: context)
        countryEntity.name = countryModel.name
        countryEntity.code = countryModel.code
        localStorage.saveContext()
        
    }
    
    private func loadCountries(){
        let context = localStorage.persistentContainer.viewContext
        do {
            countries = try context.fetch(Country.fetchRequest())
            for country in countries {
            print(country.name)
            }
        } catch let error as NSError {
            print("Could Not Fetch Currency")
        }
    }
    
}

