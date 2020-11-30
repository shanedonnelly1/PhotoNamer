//
//  ContentView.swift
//  PhotoNamer
//
//  Created by Shane on 26/11/2020.
//

import SwiftUI

struct ContentView: View {
    @State private var images: [Image] = [
        Image("apollo1"),
        Image("apollo7"),
        Image("apollo8"),
        Image("apollo9"),
        Image("apollo10")
    ]
    @State private var newImage: UIImage?
    @State private var showImagePicker = false
    @State private var showNameImage = false
    
    let columns = [
        GridItem(.adaptive(minimum: 120))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(images.indices, id: \.self) { index in
                    images[index]
                        .resizable()
                        .scaledToFit()
                }
            }
            .padding(.horizontal)
        }
        Button("Choose photo") {
            self.showImagePicker = true
        }
        .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$newImage)
        }
//        .sheet(isPresented: $showNameImage) {
//            EditPhotoName()
//        }
    }
    
    func loadImage() {
        guard let newImage = newImage else { return }
        images.append(Image(uiImage: newImage))
        self.showNameImage = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
