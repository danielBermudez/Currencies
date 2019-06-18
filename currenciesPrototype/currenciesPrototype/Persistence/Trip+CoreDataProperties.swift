//
//  Trip+CoreDataProperties.swift
//  currenciesPrototype
//
//  Created by Daniel Bermudez on 6/18/19.
//  Copyright © 2019 Endava. All rights reserved.
//
//

import Foundation
import CoreData


extension Trip {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Trip> {
        return NSFetchRequest<Trip>(entityName: "Trip")
    }

    @NSManaged public var cashAdvance: Double
    @NSManaged public var currencyRate: Double
    @NSManaged public var currencyType: String?
    @NSManaged public var destinationCountry: Country?
    @NSManaged public var expenses: NSSet?
    @NSManaged public var originCountry: Country?

}

// MARK: Generated accessors for expenses
extension Trip {

    @objc(addExpensesObject:)
    @NSManaged public func addToExpenses(_ value: Expense)

    @objc(removeExpensesObject:)
    @NSManaged public func removeFromExpenses(_ value: Expense)

    @objc(addExpenses:)
    @NSManaged public func addToExpenses(_ values: NSSet)

    @objc(removeExpenses:)
    @NSManaged public func removeFromExpenses(_ values: NSSet)

}
