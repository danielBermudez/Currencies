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
    
   func saveFrom(languageModel : LanguageModel) {
    
        let languageEntity = Language(entity: Language.entity(), insertInto: context)
        languageEntity.name = languageModel.name
        languageEntity.nativeName = languageModel.nativeName
        LocalStorage.shared.saveContext { error in
            if let error = error {
                print("Trouble saving expense data: \(error.localizedDescription)")
                
            }
            
        }
    }
}
