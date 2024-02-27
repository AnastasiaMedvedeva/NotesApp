//
//  TableViewSection.swift
//  NotesApp
//
//  Created by Анастасия on 27.02.2024.
//

import Foundation

protocol TableViewItemProtocol {
    
}
struct TableViewSection {
    var title: String
    var items: [TableViewItemProtocol]
}
