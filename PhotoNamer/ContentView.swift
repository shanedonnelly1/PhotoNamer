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
    @State private var newImageFirstName = ""
    @State private var newImageLastName = ""
    @State private var showImagePicker = false
    @State private var showNameImage = false
    let locationFetcher = LocationFetcher()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, alignment: .center, spacing: 20) {
                    ForEach(photos.items.sorted()) { photo in
                        NavigationLink(
                            destination: PhotoDetails(photo: photo).environmentObject(photos),
                            label: {
                                HStack {
                                    ZStack(alignment: .bottomLeading) {
                                        photo.image?
                                            .resizable()
                                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, maxHeight: 150)
                                            .cornerRadius(10)
                                        Text(photo.name)
                                            .font(.caption)
                                            .fontWeight(.black)
                                            .padding(8)
                                            .foregroundColor(.white)
                                            .shadow(radius: 15)
                                            .offset(x: -5, y: -5)
                                    }
                                }
                            })
                    }
                }
                .padding(.horizontal)
            }
            .padding(.top, 15)
            .sheet(isPresented: $showNameImage, onDismiss: saveImage) {
                EditPhotoName(firstName: self.$newImageFirstName, lastName: self.$newImageLastName)
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
        self.locationFetcher.start()
        self.showNameImage = true
    }
    
    func saveImage() {
        guard let newImage = newImage else { return }
        var newPhoto = Photo(firstName: newImageFirstName, lastName: newImageLastName)
        newPhoto.writeToSecureDirectory(uiImage: newImage)
        // Can we get back the image metadata? (CGImageSource maybe?  See https://youtu.be/Azhf_EfJIGM?t=463)
        if let location = self.locationFetcher.lastKnownLocation {
            newPhoto.setLocation(location: location)
        }
        photos.append(newPhoto)
        self.newImageFirstName = ""
        self.newImageLastName = ""
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
