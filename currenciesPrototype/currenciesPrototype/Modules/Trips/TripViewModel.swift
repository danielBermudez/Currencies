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
    var originCountry: Country?
    var destinationCountry: Country?
    
    
    func assignCountry (country: Country, countryType :CountryType) {
//        trip = trip ?? Trip(entity: Trip.entity(), insertInto: LocalStorage.shared.context)
        if countryType == .origin {
            originCountry = country
        } else {
            destinationCountry = country
        }
    }
    
    func listAvaiableCurrencies()-> [Currency]{
        var avaiableCurrencies = [Currency]()
        
        if let originCountry = originCountry {
            if let originCurrencies = originCountry.currency?.allObjects as? [Currency]{
            avaiableCurrencies.append(contentsOf:  originCurrencies )
        }
        }
        if let destinationCountry = destinationCountry {
            if let destinationCurrencies = destinationCountry.currency?.allObjects as? [Currency]{
                avaiableCurrencies.append(contentsOf:  destinationCurrencies )
            }
        }

        
        return avaiableCurrencies
    }
    
    func currencyRatefieldIsNeeded(currency : Currency) -> Bool {
        return trip?.originCountry?.currency?.contains(currency) ?? false
       
    }
    
    
    
    
}
