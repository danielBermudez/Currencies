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
    
    
    func testCoreData () {
        let languageViewModel = LanguageViewModel()
        let currencyViewModel = CurrencyViewModel()
//                retrieveData { (countries, error) in
//                    if let countries = countries {
//                    for country in countries {
//                        self.saveFrom(countryModel: country)
//                        for language in country.languages {
//                            self.saveFrom(languageModel: language)
//
//                        }
//                    }
//
//                    }
                    self.loadCountries()
                    languages = languageViewModel.loadLanguages()
                    print(self.languages .count)
                    print(self.countries.count)
                    let result = self.checkIfEntityExists(entity: .country, value: "USA") as? Country
                    print(result?.name)

//                }
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
 

    
    
    private func saveFrom(countryModel : CountryModel) {
      
        let countryEntity = Country (entity: Country.entity(), insertInto: context)
        countryEntity.name = countryModel.name
        countryEntity.code = countryModel.code
        LocalStorage.shared.saveContext { error in
            if let error = error {
                print("Trouble saving expense data: \(error.localizedDescription)")
          
            }
            
        }
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
    
    
    private func checkIfEntityExists(entity : EntityType, value: String) -> NSManagedObject? {
        
       
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.rawValue)
        let predicate = NSPredicate(format: "\(entity.retrieveSearchField()) CONTAINS[c] %@ ", value)
        fetchRequest.predicate = predicate
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
            return (results[0] as? NSManagedObject)
                print(results.count)
            }
        } catch {
            print("Could Not Fetch Data")
        }
        return nil
    }
    
}

