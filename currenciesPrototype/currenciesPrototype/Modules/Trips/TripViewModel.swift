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
        if countryType == .origin {
            originCountry = country
        } else {
            destinationCountry = country
        }
    }
    
    func saveTrip(cashAdvance: Double, CurrencyCode: String, currencyRate: Double?){
        trip = trip ?? Trip(entity: Trip.entity(), insertInto: LocalStorage.shared.context)
        relateOriginCountry()
        relateDestinationCountry()
        trip?.cashAdvance = cashAdvance
        if let currencyRate = currencyRate {
            trip?.currencyRate = currencyRate
        }
        LocalStorage.shared.saveContext { error in
            if let error = error {
                print (error)
            }
        }
        
    }
    
    func relateOriginCountry(){
        if let originCountry = originCountry {
            trip?.originCountry = originCountry
            
        }
    }
    
    func relateDestinationCountry(){
        if let destinationCountry = destinationCountry {
            trip?.destinationCountry = destinationCountry
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
    
    func currencyRatefieldIsNeeded(currencyCode: String) -> Bool {
        if let originCurrencies = originCountry?.currency?.allObjects as? [Currency] {
            let resultCurrencies = originCurrencies.filter {$0.code == currencyCode }
            if resultCurrencies.isEmpty {
                return false
            }
        }
    return true
    }
    
    
    
    
}
