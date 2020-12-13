//
//  Photo.swift
//  PhotoNamer
//
//  Created by Shane on 01/12/2020.
//

import Foundation
import SwiftUI
import MapKit

struct Photo: Codable, Identifiable {
    var id: UUID
    var firstName: String
    var lastName: String
    var longitude: CLLocationDegrees?
    var latitude: CLLocationDegrees?
    
    var name: String {
        return ("\(firstName) \(lastName)")
    }
    
    var image: Image? {
        let url = self.getDocumentsDirectory().appendingPathComponent("\(id).jpg")
        
        guard let uiImage = try? UIImage(data: Data(contentsOf: url)) else {
            print("Error creating UIImage from url \(url)")
            return nil
        }
        
        return Image(uiImage: uiImage)
    }
    
    var location: CLLocationCoordinate2D? {
        guard let latitude = self.latitude, let longitude = self.longitude else {
            return nil
        }
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init(firstName: String, lastName: String) {
        self.id = UUID()
        self.firstName = firstName
        self.lastName = lastName
    }
    
    init(id: UUID, firstName: String, lastName: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
    }
    
    mutating func setLocation(location: CLLocationCoordinate2D) {
        self.longitude = location.longitude
        self.latitude = location.latitude
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

extension Photo: Comparable {
    static func < (lhs: Photo, rhs: Photo) -> Bool {
        if lhs.lastName == rhs.lastName {
            return lhs.firstName.lowercased() < rhs.firstName.lowercased()
        }
        return lhs.lastName.lowercased() < rhs.lastName.lowercased()
    }
}
