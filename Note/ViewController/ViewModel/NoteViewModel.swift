//
//  NoteViewModel.swift
//  NotesApp
//
//  Created by Анастасия on 09.03.2024.
//

import Foundation

protocol NoteViewModelProtocol {
    var text: String { get }
    func delete()
    func save(with text: String)
}

final class NoteViewModel: NoteViewModelProtocol {
    let note: Note?
    var text: String {
        let text = ((note?.title ?? "") + "\n\n" + note?.description ?? "")
        return text.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    init(note: Note) {
        self.note = note
    }
    // MARK: - Methods
    func save(with text: String) {
        let data = note?.date ?? Date()
        let note = Note(title: title, description: description, imageUrl: nil)
        NotePersistent.save(note)
    }
    func delete() {
        guard let note = note else { return }
        NotePersistent.delete(note)
    }
    // MARK: - Private methods
    private func createTitleAndDescription(from text: String) -> (String, String) {
        var description = text
        
        
    }
}
