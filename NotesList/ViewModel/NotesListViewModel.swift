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
        getMocks()
    }
    
    // MARK: - Private methods
    private func getNotes() {
        let note = NotePersistent.fetchAll()
        print(note)
    }
    
    private func getMocks() {
        let section = TableViewSection(title: "22 Apr 2024", items: [Note(title: "First title note", date: Date(), description: "First note description", imageUrl: "4563", image: Data()),
                                                                    Note(title: "Second title note", date: Date(), description: "Second note description", imageUrl: "ddd", image: Data())])
        self.section = [section]
    }
}
