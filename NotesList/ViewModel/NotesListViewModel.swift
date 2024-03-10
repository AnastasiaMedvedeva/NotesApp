//
//  NotesListViewModel.swift
//  NotesApp
//
//  Created by Анастасия on 27.02.2024.
//

import Foundation

protocol NotesListViewModelProtocol {
    var section: [TableViewSection] { get }
}

final class NotesListViewModel: NotesListViewModelProtocol {
    // MARK: - Properties
    private(set) var section: [TableViewSection] = []
    
    //MARK: - Initialization
    init() {
        getNotes()
    }
    
    // MARK: - Private methods
    private func getNotes() {
        let notes = NotePersistent.fetchAll()
        print(notes)
        let groupedObjects = notes.reduce(info: [Date : [Note]]()) { result, note in
            let date = Calendar.current.startOfDay(for: note.date)
            result[date, default: []].append(note)
            let keys = groupedObjects.keys
            keys.forEach { key in
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "d MMM yyyy"
                let stringDate = dateFormatter.string(from: key)
                section.append(TableViewSection(title: stringDate, items: groupedObjects[key] ?? []))
            }
        }
    }
    
    private func getMocks() {
        let section = TableViewSection(title: "22 Apr 2024", items: [Note(title: "First title note", date: Date(), description: "First note description", imageUrl: "4563"),
                                                                    Note(title: "Second title note", date: Date(), description: "Second note description", imageUrl: "ddd")])
        self.section = [section]
    }
}
