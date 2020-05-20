//
//  Player+CoreDataProperties.swift
//  stackFoodGame
//
//  Created by Test on 5/20/20.
//  Copyright © 2020 Michael Hayes. All rights reserved.
//
//

import Foundation
import CoreData


extension Player {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Player> {
        return NSFetchRequest<Player>(entityName: "Player")
    }

    @NSManaged public var coins: Int16
    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var xp: Int16
    @NSManaged public var avatar: Avatar?
    @NSManaged public var food: Food?
    @NSManaged public var gameHistory: NSSet?
    @NSManaged public var location: Location?

}

// MARK: Generated accessors for gameHistory
extension Player {

    @objc(addGameHistoryObject:)
    @NSManaged public func addToGameHistory(_ value: GameHistory)

    @objc(removeGameHistoryObject:)
    @NSManaged public func removeFromGameHistory(_ value: GameHistory)

    @objc(addGameHistory:)
    @NSManaged public func addToGameHistory(_ values: NSSet)

    @objc(removeGameHistory:)
    @NSManaged public func removeFromGameHistory(_ values: NSSet)

}
