//
//  Currency+CoreDataProperties.swift
//  currenciesPrototype
//
//  Created by Daniel Bermudez on 6/20/19.
//  Copyright © 2019 Endava. All rights reserved.
//
//

import Foundation
import CoreData


extension Currency {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Currency> {
        return NSFetchRequest<Currency>(entityName: "Currency")
    }

    @NSManaged public var code: String?
    @NSManaged public var name: String?
    @NSManaged public var symbol: String?
    @NSManaged public var countries: NSSet?

}

// MARK: Generated accessors for countries
extension Currency {

    @objc(addCountriesObject:)
    @NSManaged public func addToCountries(_ value: Country)

    @objc(removeCountriesObject:)
    @NSManaged public func removeFromCountries(_ value: Country)

    @objc(addCountries:)
    @NSManaged public func addToCountries(_ values: NSSet)

    @objc(removeCountries:)
    @NSManaged public func removeFromCountries(_ values: NSSet)

}
