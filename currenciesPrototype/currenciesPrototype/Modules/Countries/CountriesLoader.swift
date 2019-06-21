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
    
    
    func testCoreData () {
        //        retrieveData { (countries, error) in
        //            if let countries = countries {
        //            for country in countries {
        //                self.saveFrom(countryModel: country)
        //                for language in country.languages {
        //                    self.saveFrom(languageModel: language)
        //                }
        //            }
        //
        //        }
        //        }
        //        self.loadCountries()
        self.loadLanguages()
        print(languages .count)
        let result = self.checkIfEntityExists(entity: .country, value: "USA") as? Country
        print(result?.name)
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
    
    private func saveFrom(currencyModel : CurrencyModel) {
        let context = localStorage.persistentContainer.viewContext
        let currencyEntity = Currency (entity: Currency.entity(), insertInto: context)
        currencyEntity.name = currencyModel.name
        currencyEntity.code = currencyModel.name
        currencyEntity.symbol = currencyModel.symbol
        localStorage.saveContext()
    }
    
    private func saveFrom(countryModel : CountryModel) {
        let context = localStorage.persistentContainer.viewContext
        let countryEntity = Country (entity: Country.entity(), insertInto: context)
        countryEntity.name = countryModel.name
        countryEntity.code = countryModel.code
        localStorage.saveContext()
    }
    
    private func saveFrom(languageModel : LanguageModel) {
        let context = localStorage.persistentContainer.viewContext
        let languageEntity = Language(entity: Language.entity(), insertInto: context)
        languageEntity.name = languageModel.name
        languageEntity.nativeName = languageModel.nativeName
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
    
    private func loadLanguages(){
        let context = localStorage.persistentContainer.viewContext
        do {
            languages = try context.fetch(Language.fetchRequest())
            for language in languages {
                print(language.name)
            }
        } catch let error as NSError {
            print("Could Not Fetch Currency")
        }
    }
    private func checkIfEntityExists(entity : EntityType, value: String) -> NSManagedObject? {
        
        let context = localStorage.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.rawValue)
        let predicate = NSPredicate(format: "\(entity.retrieveSearchField()) CONTAINS[c] %@ ", value)
        fetchRequest.predicate = predicate
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
            return (results[0] as? NSManagedObject)
            }
        } catch {
            print("Could Not Fetch Data")
        }
        return nil
    }
    
}

