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
        let imageName = url.lastPathComponent
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
    static func read(from url: URL) -> UIImage? {
        UIImage(contentsOfFile: url.path)
    }
    static func delete(from url: URL) {
        do {
            try FileManager.default.removeItem(at: url)
            print("Image was deleted")
        } catch {
            print("Saving image error: \(error)")
        }
    }
}
