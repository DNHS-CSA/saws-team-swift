//
//  Powerup+CoreDataProperties.swift
//  stackFoodGame
//
//  Created by Test on 5/20/20.
//  Copyright © 2020 Michael Hayes. All rights reserved.
//
//

import UIKit
import CoreData


extension Powerup {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Powerup> {
        return NSFetchRequest<Powerup>(entityName: "Powerup")
    }

    @NSManaged public var iconName: String?
    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var value: Double

}
