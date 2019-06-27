//
//  CurrencyViewModel.swift
//  currenciesPrototype
//
//  Created by Daniel Bermudez on 6/21/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import Foundation
class CurrencyViewModel {
    private let context = LocalStorage.shared.context
    
    private func loadCurrencies() -> [Currency]{
        var currencies = [Currency]()
        do {
            currencies = try context.fetch(Currency.fetchRequest())
        } catch let error as NSError {
            print("Could Not Fetch Currency")
        }
        return currencies
    }
    
     func convertFrom(currencyModel : CurrencyModel) -> Currency? {
        if currencyModel.code != nil {
        let currencyEntity = Currency (entity: Currency.entity(), insertInto: context)
        currencyEntity.name = currencyModel.name
        currencyEntity.code = currencyModel.code
        currencyEntity.symbol = currencyModel.symbol
        return currencyEntity
        } else {
            return nil 
        }
    
    }
    
     func convertCurrencyIn(country:CountryModel)-> [Currency] {       
        var currencyEntities = [Currency]()
        for currency in country.currencies {
            if let currencyEntity = convertFrom(currencyModel: currency) {
                currencyEntities.append(currencyEntity)
            }
            
        }
        return currencyEntities
    }
    
}
