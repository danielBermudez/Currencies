//
//  Language+CoreDataProperties.swift
//  currenciesPrototype
//
//  Created by Daniel Bermudez on 6/18/19.
//  Copyright © 2019 Endava. All rights reserved.
//
//

import Foundation
import CoreData


extension Language {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Language> {
        return NSFetchRequest<Language>(entityName: "Language")
    }

    @NSManaged public var name: String?
    @NSManaged public var nativeName: String?
    @NSManaged public var country: Country?
}
