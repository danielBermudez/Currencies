//
//  Currency+CoreDataProperties.swift
//  currenciesPrototype
//
//  Created by Daniel Bermudez on 6/18/19.
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

}
