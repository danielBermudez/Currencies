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
//            print(currencies[0].name)
        } catch let error as NSError {
            print("Could Not Fetch Currency")
        }
        return currencies
    }
    
    private func saveFrom(currencyModel : CurrencyModel) {
        let currencyEntity = Currency (entity: Currency.entity(), insertInto: context)
        currencyEntity.name = currencyModel.name
        currencyEntity.code = currencyModel.name
        currencyEntity.symbol = currencyModel.symbol
        LocalStorage.shared.saveContext { error in
            if let error = error {
                print("Trouble saving expense data: \(error.localizedDescription)")
            }
        }
    }
    
}
