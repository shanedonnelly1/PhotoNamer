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
            // Save
        }
    }
    
    init() {
        if let decoded = Bundle.main.decode("photos.json") as [Photo]? {
            self.items = decoded
            return
        }
        self.items = []
    }
    
    func append(_ item: Photo) {
        self.items.append(item)
    }
}
