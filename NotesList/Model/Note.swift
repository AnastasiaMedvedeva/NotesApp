//
//  Note.swift
//  NotesApp
//
//  Created by Анастасия on 27.02.2024.
//

import Foundation

struct Note: TableViewItemProtocol {
    let title: String
    let date: Date
    let description: String
    let imageUrl: String?
    let image: Data?
}
