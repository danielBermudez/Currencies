//
//  Expense+CoreDataProperties.swift
//  currenciesPrototype
//
//  Created by Daniel Bermudez on 7/4/19.
//  Copyright © 2019 Endava. All rights reserved.
//
//

import Foundation
import CoreData


extension Expense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expense> {
        return NSFetchRequest<Expense>(entityName: "Expense")
    }

    @NSManaged public var currencyRate: Double
    @NSManaged public var currencyType: String?
    @NSManaged public var amount: Double

}
