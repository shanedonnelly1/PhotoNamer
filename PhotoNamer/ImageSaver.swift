//
//  ImageSaver.swift
//  PhotoNamer
//
//  Created by Shane on 01/12/2020.
//

import Foundation
import UIKit

class ImageSaver: NSObject {
    func writeToSecureDirectory(uiImage: UIImage, name: String) -> URL? {
        if let jpegData = uiImage.jpegData(compressionQuality: 0.8) {
            let url = self.getDocumentsDirectory().appendingPathComponent("\(name).jpg")
            try? jpegData.write(to: url, options: [.atomicWrite, .completeFileProtection])
            return url
            // What do we do about the save error?
        }
        return nil
    }
    
    func deleteFromSecureDirectory(name: String) -> Bool {
        let fileUrl = self.getDocumentsDirectory().appendingPathComponent("\(name).jpg")
        let filePath = fileUrl.path
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath) {
            try? fileManager.removeItem(atPath: filePath)
            // This doesn't look right
            return true
        } else {
            print("File at path \(filePath) does not exist")
            return false
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
