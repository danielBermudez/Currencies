//
//  TripViewModel.swift
//  currenciesPrototype
//
//  Created by Daniel Bermudez on 7/3/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import Foundation
class TripViewModel {
    var trip : Trip?
    
    
    func assignCountry (country: Country, countryType :CountryType) {
        trip = trip ?? Trip(entity: Trip.entity(), insertInto: LocalStorage.shared.context)
        if countryType == .origin {
            trip!.originCountry = country
        } else {
            trip!.destinationCountry = country
        }
    }
    
    func listAvaiableCurrencies()-> [Currency] {
        var avaiableCurrencies = [Currency]()
        if let originCurrencies = trip!.originCountry?.currency?.allObjects as? [Currency]{
            avaiableCurrencies.append(contentsOf: originCurrencies)
        }
        if let destinationCurrencies = trip!.destinationCountry?.currency?.allObjects as? [Currency]{
            avaiableCurrencies.append(contentsOf: destinationCurrencies)
        }
        return avaiableCurrencies
    }
    
    func currencyRatefieldIsNeeded(currency : Currency) -> Bool {
        return trip?.originCountry?.currency?.contains(currency) ?? false
       
    }
    
    
    
    
}
