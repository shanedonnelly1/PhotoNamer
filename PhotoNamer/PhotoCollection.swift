//
//  PhotoCollection.swift
//  PhotoNamer
//
//  Created by Shane on 03/12/2020.
//

import Foundation

class PhotoCollection: ObservableObject {
    @Published var items = [Photo]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(items) {
                let url = self.getDocumentsDirectory().appendingPathComponent("photos.json")
                print("URL: \(url)")
                try? encoded.write(to: url, options: [.atomicWrite, .completeFileProtection])
            } else {
                // @TODO: Replace with proper error handling
                fatalError("Error")
            }
        }
    }
    
    init() {

        let file = "photos.json"
        let url = self.getDocumentsDirectory().appendingPathComponent(file)
        // Make sure file is there
        
        // Set a default empty array of items
//        self.items = []
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()
        guard let decodedPhotos = try? decoder.decode([Photo].self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
                
        self.items = decodedPhotos
    }
    
    func append(_ item: Photo) {
        self.items.append(item)
    }
    
    // @TODO: This is a duplicate of the ImageSaver function.  Move to an extension
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
