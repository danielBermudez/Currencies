//
//  Country+CoreDataProperties.swift
//  currenciesPrototype
//
//  Created by Daniel Bermudez on 6/18/19.
//  Copyright © 2019 Endava. All rights reserved.
//
//

import Foundation
import CoreData


extension Country {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }

    @NSManaged public var alpha3Code: String?
    @NSManaged public var name: String?
    @NSManaged public var currency: NSSet?
    @NSManaged public var languages: NSSet?

}

// MARK: Generated accessors for currency
extension Country {

    @objc(addCurrencyObject:)
    @NSManaged public func addToCurrency(_ value: Currency)

    @objc(removeCurrencyObject:)
    @NSManaged public func removeFromCurrency(_ value: Currency)

    @objc(addCurrency:)
    @NSManaged public func addToCurrency(_ values: NSSet)

    @objc(removeCurrency:)
    @NSManaged public func removeFromCurrency(_ values: NSSet)

}

// MARK: Generated accessors for languages
extension Country {

    @objc(addLanguagesObject:)
    @NSManaged public func addToLanguages(_ value: Language)

    @objc(removeLanguagesObject:)
    @NSManaged public func removeFromLanguages(_ value: Language)

    @objc(addLanguages:)
    @NSManaged public func addToLanguages(_ values: NSSet)

    @objc(removeLanguages:)
    @NSManaged public func removeFromLanguages(_ values: NSSet)

}
