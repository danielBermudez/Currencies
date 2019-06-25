//
//  Country.swift
//  currenciesPrototype
//
//  Created by Daniel Bermudez on 6/19/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import Foundation


struct  CountryModel : Codable {
    let code : String
    let name : String
    let currencies : [CurrencyModel]
    let languages : [LanguageModel]
    enum CodingKeys : String,CodingKey {
        case name = "name"
        case code = "alpha3Code"
        case currencies = "currencies"
        case languages =  "languages"
        
    }
}

struct LanguageModel : Codable {
    let name : String?
    let nativeName : String?
}

struct CurrencyModel : Codable {
    let code : String?
    let name : String?
    let symbol : String?
}
