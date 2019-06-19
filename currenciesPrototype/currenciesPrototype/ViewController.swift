//
//  ViewController.swift
//  currenciesPrototype
//
//  Created by Daniel Bermudez on 6/17/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func AddTripTouched(_ sender: Any) {
        addTrip()
        print("\n\(trips.count)   ------------------------------\n")
        for country in trips {
            print("\(country.name), \(country.currency)")
        }
    }
    
    @IBAction func DeleteTripsTouched(_ sender: Any) {
        deleteTrips()
    }
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var trips = [Country]()
    private var filtered = [Trip]()
    private var isFiltered = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        do {
            trips = try context.fetch(Country.fetchRequest())
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    private func addTrip() {
        let country = Country(entity: Country.entity(), insertInto: context)
        let currency = Currency(entity: Currency.entity(), insertInto: context)
        country.name = "Colombia"
        country.alpha3Code = "COL"
        currency.code = "COP"
        currency.name = "Colombian Peso"
        currency.symbol = "$"
        currency.country = country
        
//        country.currency?.adding(currency)
        
        appDelegate.saveContext()
        trips.append(country)
    }
    
    private func deleteTrips(){
        for object in trips {
            context.delete(object)
        }
    }
}

