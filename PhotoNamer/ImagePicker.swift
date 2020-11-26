//
//  ImagePicker.swift
//  PhotoNamer
//
//  Created by Shane on 26/11/2020.
//

import Foundation
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
   
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        return picker
    }
     
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: UIViewControllerRepresentableContext<ImagePicker>) {
        // Do something
    }
}
