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
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, alignment: .center, spacing: 20) {
                    ForEach(photos.items) { photo in
                        HStack {
                            ZStack(alignment: .bottomTrailing) {
                                photo.image?
                                    .resizable()
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, maxHeight: 150)
                                    .cornerRadius(10)
                                Text(photo.name)
                                    .font(.caption)
                                    .fontWeight(.black)
                                    .padding(8)
                                    .foregroundColor(.white)
                                    .offset(x: -5, y: -5)
                            }
                        }
                        
                    }
                    
                }
                .padding(.horizontal)
            }
            .padding(.top, 5)
            .sheet(isPresented: $showNameImage, onDismiss: saveImage) {
                EditPhotoName(photoName: self.$newImageName)
            }
            .navigationBarTitle("Photo Namer", displayMode: .inline)
            .navigationBarItems(
                trailing: Button("Add") {
                    self.showImagePicker = true
                }
                .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                    ImagePicker(image: self.$newImage)
                }
            )
        }
    }
    
    func loadImage() {
        self.showNameImage = true
    }
    
    func saveImage() {
        guard let newImage = newImage else { return }
        if newImageName == "" {
            newImageName = UUID().uuidString
        }
        var newPhoto = Photo(name: newImageName)
        newPhoto.writeToSecureDirectory(uiImage: newImage)
        photos.append(newPhoto)
        self.newImageName = ""
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
