//
//  Photo.swift
//  PhotoNamer
//
//  Created by Shane on 01/12/2020.
//

import Foundation
import SwiftUI

struct Photo: Codable {
    var name: String
    var url: URL?
    
    var image: Image? {
        Image(uiImage: self.uiImage!)
    }
    
    var uiImage: UIImage? {
        if let url = url {
            return try? UIImage(data: Data(contentsOf: url))
        } else {
            return UIImage(named: name)
        }
    }
    
    mutating func writeToSecureDirectory(uiImage: UIImage) {
        let imageSaver = ImageSaver()
        url = imageSaver.writeToSecureDirectory(uiImage: uiImage, name: name)
    }
}
