//
//  SongTable+CoreDataProperties.swift
//  
//
//  Created by Sarang Jiwane on 22/12/18.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension SongTable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SongTable> {
        return NSFetchRequest<SongTable>(entityName: "SongTable")
    }

    @NSManaged public var artist: String?
    @NSManaged public var title: String?
    @NSManaged public var urlString: String?

}
