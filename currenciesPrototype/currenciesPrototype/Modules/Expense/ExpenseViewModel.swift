//
//  ExpenseViewModel.swift
//  currenciesPrototype
//
//  Created by Daniel Bermudez on 7/4/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import Foundation
class ExpenseViewModel {
    var trip : Trip?
    
    
    func saveExpense(currencyType: String, currencyRate : Double?, amount : Double) {
        let expense = Expense(entity: Expense.entity(), insertInto: LocalStorage.shared.context)
        expense.amount = amount
        expense.currencyType = currencyType
        if let currencyRate = currencyRate {
           expense.currencyRate = currencyRate
        }
        trip?.addToExpenses(expense)
        LocalStorage.shared.saveContext { error in
            if let error = error {
                print(error)
            }
        }
    }
    
    func listAvaiableCurrencies()-> [Currency]{
        var avaiableCurrencies = [Currency]()
        
        if let originCountry = trip?.originCountry {
            if let originCurrencies = originCountry.currency?.allObjects as? [Currency]{
                avaiableCurrencies.append(contentsOf:  originCurrencies )
            }
        }
        if let destinationCountry = trip?.destinationCountry {
            if let destinationCurrencies = destinationCountry.currency?.allObjects as? [Currency]{
                avaiableCurrencies.append(contentsOf:  destinationCurrencies )
            }
        }
        
        
        return avaiableCurrencies
    }
    
    func currencyRatefieldIsNeeded(currencyCode: String) -> Bool {
        if let originCurrencies = trip?.originCountry?.currency?.allObjects as? [Currency] {
            let resultCurrencies = originCurrencies.filter {$0.code == currencyCode }
            if resultCurrencies.isEmpty {
                return false
            }
        }
        return true
    }

}
