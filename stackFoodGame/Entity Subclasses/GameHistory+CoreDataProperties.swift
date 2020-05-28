//
//  GameHistory+CoreDataProperties.swift
//  stackFoodGame
//
//  Created by Test on 5/20/20.
//  Copyright © 2020 Michael Hayes. All rights reserved.
//
//

import Foundation
import CoreData


extension GameHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GameHistory> {
        return NSFetchRequest<GameHistory>(entityName: "GameHistory")
    }

    @NSManaged public var coins: Int16
    @NSManaged public var date: Date?
    @NSManaged public var id: Int16
    @NSManaged public var avatarName: String
    @NSManaged public var avatar: Avatar?
    @NSManaged public var food: Food?
    @NSManaged public var location: Location?
    @NSManaged public var player: Player?

}
