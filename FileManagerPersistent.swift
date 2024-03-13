//
//  FileManagerPersistent.swift
//  NotesApp
//
//  Created by Анастасия on 13.03.2024.
//

import Foundation
import UIKit

final class FileManagerPersistent {
    static func save(_ image: UIImage, with name: String) -> URL? {
        let data = image.jpegData(compressionQuality: 1)
        let url = getDocumentDirectory().appendingPathComponent(name)
        do {
            try data?.write(to: url)
            print("Image was saved")
            return nil
        } catch {
            print("Saving image error: \(error)")
            return nil
        }
    }
    
    private static func getDocumentDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
