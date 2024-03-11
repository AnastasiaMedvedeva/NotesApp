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
        var entity: NoteEntity?
        if let ent = getEntity(for: note) {
            entity = ent
        } else {
            guard let description = NSEntityDescription.entity(forEntityName: "NoteEntity", in: context) else { return }
            entity = NoteEntity(entity: description, insertInto: context)
        }
        entity?.title = note.title
        entity?.text = note.description
        entity?.date = note.date
        entity?.imageUrl = note.imageUrl
        saveContext()
    }
    
    static func delete(_ note: Note) {
        guard let entity = getEntity(for: note) else { return }
        context.delete(entity)
        saveContext()
//        postNotification()
    }
    static func fetchAll() -> [Note] {
        let request = NoteEntity.fetchRequest()
        do {
            let object = try context.fetch(request)
            return convert(entities: object)
        } catch let error {
            debugPrint("Fetch notes error: \(error)")
            return []
        }
    }
    private static func getEntity(for note: Note) -> NoteEntity? {
        let request = NoteEntity.fetchRequest()
        let predicate = NSPredicate(format: "date = %@", note.date as NSDate)
        request.predicate = predicate
        do {
            let objects = try context.fetch(request)
            return objects.first
        } catch let error {
            debugPrint("Fetch notes error: \(error)")
            return nil
        }
    }
    
    private static func saveContext() {
        do {
            try context.save()
            postNotification()
        } catch let error {
            debugPrint("Save note error: \(error)")
        }
    }
    private static func convert(entities: [NoteEntity]) -> [Note] {
        let notes = entities.map {
            Note(title: $0.title ?? "",
                 date: $0.date ?? Date(),
                 description: $0.text,
                 imageUrl: $0.imageUrl)
        }
        return notes
    }
    private static func postNotification() {
        NotificationCenter.default.post(name: NSNotification.Name("update"), object: nil)
    }
}
