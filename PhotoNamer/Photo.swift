//
//  Photo.swift
//  PhotoNamer
//
//  Created by Shane on 01/12/2020.
//

import Foundation
import SwiftUI

struct Photo: Codable, Identifiable {
    var name: String
    var id: UUID
    
    var image: Image? {
        let url = self.getDocumentsDirectory().appendingPathComponent("\(id).jpg")
        
        guard let uiImage = try? UIImage(data: Data(contentsOf: url)) else {
            print("Error creating UIImage from url \(url)")
            return nil
        }
        
        return Image(uiImage: uiImage)
    }
    
    init(name: String) {
        self.id = UUID()
        self.name = name
    }
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
    
    mutating func writeToSecureDirectory(uiImage: UIImage) {
        let imageSaver = ImageSaver()
        let _ = imageSaver.writeToSecureDirectory(uiImage: uiImage, name: id.uuidString)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
