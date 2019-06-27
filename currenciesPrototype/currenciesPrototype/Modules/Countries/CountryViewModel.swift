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
    private var currencies = [Currency]()
    private var countries = [Country]()
    private var languages = [Language]()
    
    private enum EntityType : String {
        case language = "Language"
        case currency = "Currency"
        case country = "Country"
        
        func retrieveSearchField()-> String{
            switch self {
            case .language :
                return "name"
            case .currency :
                return "code"
            case .country:
                return "code"
            }
        }
    }
    
    func saveData() {
        retrieveData { [weak self] (countries, error) in
            guard let strongSelf = self else {return}
            let languageViewModel = LanguageViewModel()
            let currencyViewModel = CurrencyViewModel()
            if let countries = countries {
                for country in countries {
                    
                    let countryEntity = strongSelf.creatEntityFrom(countryModel: country)
                    let languages = languageViewModel.convertLanguagesIn(country: country)
                    let currencies = currencyViewModel.convertCurrencyIn(country: country)
                    strongSelf.relate(languagesTo: languages, country: countryEntity)
                    strongSelf.relate(currenciesTo: currencies, country: countryEntity)
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
    
    private func creatEntityFrom(countryModel : CountryModel) -> Country{
        
        let countryEntity = Country (entity: Country.entity(), insertInto: context)
        countryEntity.name = countryModel.name
        countryEntity.code = countryModel.code

        return countryEntity
    }
    
    
    
    private func loadCountries(){
        do {
            countries = try context.fetch(Country.fetchRequest())
            for country in countries {
                print(country.name)
            }
        } catch let error as NSError {
            print("Could Not Fetch Cuountries")
        }
    }
    
    private func relate(languagesTo languages :[Language], country: Country){
        for language in languages {
            country.addToLanguages(language)
        }
        
    }
       
    private func relate(currenciesTo currencies :[Currency], country: Country){
        for currency in currencies {
            country.addToCurrency(currency)
        }
        
    }
    
    private func saveContext () {
        LocalStorage.shared.saveContext { error in
            if let error = error {
                print("Trouble saving expense data: \(error.localizedDescription)")
                
            }
            
        }
    }
    
    
    private func checkIfEntityExists(entity : EntityType, value: String) -> NSManagedObject? {
        
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.rawValue)
        let predicate = NSPredicate(format: "\(entity.retrieveSearchField()) CONTAINS[c] %@ ", value)
        fetchRequest.predicate = predicate
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                print(results.count)
                return (results[0] as? NSManagedObject)
                            }
        } catch {
            print("Could Not Fetch Data")
        }
        return nil
    }
    
}

