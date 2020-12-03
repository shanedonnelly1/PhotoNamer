//
//  ContentView.swift
//  PhotoNamer
//
//  Created by Shane on 26/11/2020.
//

import SwiftUI

struct ContentView: View {
    // This should probably be an object that holds an array of photos
    // and contains a method to save and load the names.
    @ObservedObject var photos = PhotoCollection()
    @State private var newImage: UIImage?
    @State private var newImageName = ""
    @State private var showImagePicker = false
    @State private var showNameImage = false
    
    let columns = [
        GridItem(.adaptive(minimum: 120))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(photos.items, id: \.name) { photo in
                    photo.image?
                        .resizable()
                        .scaledToFit()
                }
            }
            .padding(.horizontal)
        }
        .sheet(isPresented: $showNameImage, onDismiss: saveImage) {
            EditPhotoName(photoName: self.$newImageName)
        }
        Button("Choose photo") {
            self.showImagePicker = true
        }
        .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$newImage)
        }
//        .onAppear(perform: loadPhotos)
    }
    
    func loadImage() {
        self.showNameImage = true
    }
    
    func saveImage() {
        guard let newImage = newImage else { return }
        var newPhoto = Photo(name: newImageName)
        newPhoto.writeToSecureDirectory(uiImage: newImage)
        photos.append(newPhoto)
    }
    
//    func loadPhotos() {
//        // Get all the file names from storage and create
//        // new photos for each of them.
//        photos.append(Photo(name: "apollo1"))
//        photos.append(Photo(name: "apollo7"))
//        photos.append(Photo(name: "apollo8"))
//        photos.append(Photo(name: "apollo9"))
//        photos.append(Photo(name: "apollo10"))
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
