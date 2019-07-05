//
//  CountriesLoader.swift
//  currenciesPrototype
//
//  Created by Daniel Bermudez on 6/20/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import Foundation
import CoreData

class CountryViewModel {
    private let apiClient = APIClient()
    private let context = LocalStorage.shared.context
    
    func saveData() {
        retrieveData { [weak self] (countries, error) in
            guard let strongSelf = self else {return}
            let languageViewModel = LanguageViewModel()
            let currencyViewModel = CurrencyViewModel()
            if let countries = countries {
                for countryModel in countries {
                    let countryEntity = strongSelf.createEntityFrom(countryModel: countryModel)
                    let languages = languageViewModel.convertLanguagesIn(country: countryModel)
                    let currencies = currencyViewModel.convertCurrencyIn(country: countryModel)
                    strongSelf.relate(languages: languages, to: countryEntity)
                    strongSelf.relate(currencies: currencies, to: countryEntity)
                    strongSelf.saveContext()
                }
            }
        }
        
    }
    
    private func retrieveData (completion : @escaping ([CountryModel]?,Error?)->Void) {
        apiClient.retrieveCountries {  response in
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
    
    private func createEntityFrom(countryModel : CountryModel) -> Country {
        let countryEntity = Country (entity: Country.entity(), insertInto: context)
        countryEntity.name = countryModel.name
        countryEntity.code = countryModel.code
        
        return countryEntity
    }
    
    private func relate(languages :[Language],to country: Country) {
        for language in languages {
            country.addToLanguages(language)
        }
        
    }
    
    private func relate(currencies :[Currency], to country: Country) {
        for currency in currencies {
            country.addToCurrency(currency)
        }
        
    }
    
    private func saveContext () {
        LocalStorage.shared.saveContext { error in
            if let error = error {
                print("Trouble saving data: \(error.localizedDescription)")
                
            }
            
        }
    }
    
    func filtercontries(countryName :String)-> [Country]{
        let fetchRequest: NSFetchRequest<Country> = Country.fetchRequest()
        let predicate =  NSPredicate(format: "name CONTAINS[c] %@  ", countryName)
        fetchRequest.predicate = predicate
        var results = [Country]()
        do {
            results = try context.fetch(fetchRequest)
        }  catch {
            print("Could Not Fetch Data")
        }
        return results
    }
}

