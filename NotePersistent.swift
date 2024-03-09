//
//  NotePersistent.swift
//  NotesApp
//
//  Created by Анастасия on 09.03.2024.
//

import Foundation
import CoreData

final class NotePersistent {
    private static let context = AppDelegate.persistentContainer.viewContext
    
    static func save(_ note: Note) {
        
    }
    
    static func delete(_ note: Note) {
        
    }
    static func fetchAll() -> [Note] {
        
        return []
    }
}
