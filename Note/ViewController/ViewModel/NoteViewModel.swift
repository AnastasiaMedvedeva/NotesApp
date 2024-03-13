//
//  NoteViewModel.swift
//  NotesApp
//
//  Created by Анастасия on 09.03.2024.
//

import Foundation
import UIKit

protocol NoteViewModelProtocol {
    var text: String { get }
    func delete()
    func save(with text: String,and image: UIImage?)
}

final class NoteViewModel: NoteViewModelProtocol {
    let note: Note?
    var text: String {
        let text = ((note?.title ?? "") + "\n\n" + (note?.description?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "") )
        return text.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    init(note: Note) {
        self.note = note
    }
    // MARK: - Methods
    func save(with text: String,and image: UIImage?)
    if let image = image {
        FileManagerPersistent.save(image, with:)
        let date = note?.date ?? Date()
        let (title, description) = createTitleAndDescription(from: text)
        let note = Note(title: title, date: date, description: description ?? "", imageUrl: nil)
        NotePersistent.save(note)
    }
    func delete() {
        guard let note = note else { return }
        NotePersistent.delete(note)
    }
    // MARK: - Private methods
    func createTitleAndDescription(from text: String) -> (String, String?) {
        var description = text
        guard let index = description.firstIndex(where: { $0 == "." || $0 == "!" || $0 == "?" || $0 == "\n"}) else { return (text, nil)}
            let title = String(description[...index])
            description.removeSubrange(...index)
            return (title, description)
    }
}
