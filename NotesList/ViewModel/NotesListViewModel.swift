//
//  NotesListViewModel.swift
//  NotesApp
//
//  Created by Анастасия on 27.02.2024.
//

import Foundation
import UIKit

protocol NotesListViewModelProtocol {
    var section: [TableViewSection] { get }
    func getNotes()
    var reloadTable: (() -> Void)? { get set }
    func getImage(for note: Note) -> UIImage?
}

final class NotesListViewModel: NotesListViewModelProtocol {
    // MARK: - Properties
    var reloadTable: (() -> Void)?
    private(set) var section: [TableViewSection] = [] {
        didSet {
            reloadTable?()
        }
    }
    //MARK: - Initialization
    init() {
        getNotes()
    }
    // MARK: - Methods
    func getImage(for note: Note) -> UIImage? {
        FileManagerPersistent.read(from: note.imageURL)
    }
    // MARK: - Private methods
    func getNotes() {
        let notes = NotePersistent.fetchAll()
        section = []
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
        let section = TableViewSection(title: "22 Apr 2024", items: [Note(title: "First title note", date: Date(), description: "First note description", imageUrl: URL(string: "")),
                                                                     Note(title: "Second title note", date: Date(), description: "Second note description", imageUrl: URL(string: ""))])
        self.section = [section]
    }
}
