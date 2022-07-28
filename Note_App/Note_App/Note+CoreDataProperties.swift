//
//  Note+CoreDataProperties.swift
//  Note_App
//
//  Created by Ismayil Ismayilov on 28.07.22.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var body: String?
    @NSManaged public var title: String?

}

extension Note : Identifiable {

}
