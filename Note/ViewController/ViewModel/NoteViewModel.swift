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
    var image: UIImage? { get }
    
    func save(with text: String,and image: UIImage?, imageName: String?)
    func delete()
}

final class NoteViewModel: NoteViewModelProtocol {
    let note: Note?
    var text: String {
        let text = ((note?.title ?? "") + "\n\n" + (note?.description?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "") )
        return text.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    var image: UIImage? {
        guard let url = note?.imageURL else { return nil }
        return FileManagerPersistent.read(from: url)
    }
    
    // MARK: - Initialization
    init(note: Note) {
        self.note = note
    }
    // MARK: - Methods
    func save(with text: String,and image: UIImage?, imageName: String?) {
        var url: URL?
        if let image = image,
           let name = imageName {
            url = FileManagerPersistent.save(image, with: name)
        }
            let date = note?.date ?? Date()
            let (title, description) = createTitleAndDescription(from: text)
        
            let note = Note(title: title, date: date, description: description ?? "", imageUrl: url)
            NotePersistent.save(note)
        }
    func delete() {
        guard let note = note else { return }
        if let url = note.imageURL {
            FileManagerPersistent.delete(from: url)
        }
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

