//
//  LanguageViewModel.swift
//  currenciesPrototype
//
//  Created by Daniel Bermudez on 6/21/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import Foundation

class LanguageViewModel {
    private let context = LocalStorage.shared.context
    
    func loadLanguages()-> [Language] {
        var languages = [Language]()
        do {
            languages = try context.fetch(Language.fetchRequest())
            for language in languages {
                print(language.name)
            }
        } catch let error as NSError {
            print("Could Not Fetch Languages : \(error.localizedDescription)")
        }
        return languages
    }
    
   func convertFrom(languageModel : LanguageModel) -> Language{
    
        let languageEntity = Language(entity: Language.entity(), insertInto: context)
        languageEntity.name = languageModel.name
        languageEntity.nativeName = languageModel.nativeName
    return languageEntity
    }
    
    func convertLanguagesIn(country:CountryModel)-> [Language] {
        var languageEntities = [Language]()
        for language in country.languages {
            if language.name != nil {
                languageEntities.append(convertFrom(languageModel: language))
            }
        }
        return languageEntities
    }
}
