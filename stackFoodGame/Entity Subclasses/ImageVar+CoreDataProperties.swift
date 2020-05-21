//
//  ImageVar+CoreDataProperties.swift
//  stackFoodGame
//
//  Created by Test on 5/20/20.
//  Copyright © 2020 Michael Hayes. All rights reserved.
//
//

import Foundation
import CoreData


extension ImageVar {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageVar> {
        return NSFetchRequest<ImageVar>(entityName: "ImageVar")
    }

    @NSManaged public var count: Int16
    @NSManaged public var imagescreen: Int16

}
