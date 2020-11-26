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
    @State private var showImagePicker = false
    
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
        .sheet(isPresented: $showImagePicker) {
            ImagePicker()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
