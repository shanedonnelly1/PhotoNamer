//
//  PhotoDetails.swift
//  PhotoNamer
//
//  Created by Shane on 13/12/2020.
//

import SwiftUI

struct PhotoDetails: View {
    var photo: Photo
    @State private var newImageFirstName = ""
    @State private var newImageLastName = ""
    @State private var showNameImage = false
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomLeading) {
                photo.image?
                    .resizable()
                    .scaledToFit()
                
                Text(photo.name)
                    .font(.title)
                    .fontWeight(.black)
                    .padding(16)
                    .foregroundColor(.white)
                    .offset(x: -5, y: -5)
            }
            Spacer()
        }
        .navigationBarTitle(photo.firstName, displayMode: .inline)
        .navigationBarItems(trailing: Button("Edit") {
            self.showNameImage = true
        })
        .sheet(isPresented: $showNameImage, onDismiss: saveImageName) {
            EditPhotoName(firstName: self.$newImageFirstName, lastName: self.$newImageLastName)
        }
        .onAppear() {
            self.newImageFirstName = self.photo.firstName
            self.newImageLastName = self.photo.lastName
        }
    }
    
    func saveImageName() {
        var photos = PhotoCollection()
        let photoIndex = photos.items.firstIndex(where: { $0.id == self.photo.id })
        if let photoIndex = photoIndex {
            photos.items[photoIndex].firstName = self.newImageFirstName
            photos.items[photoIndex].lastName = self.newImageLastName
        }
    }
}

struct PhotoDetails_Previews: PreviewProvider {
    static var previews: some View {
        PhotoDetails(photo: PhotoCollection().items[0])
    }
}
