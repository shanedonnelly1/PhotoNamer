//
//  EditPhotoName.swift
//  PhotoNamer
//
//  Created by Shane on 30/11/2020.
//

import SwiftUI

struct EditPhotoName: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var photoName: String
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name the new photo:")) {
                    TextField("Photo name", text: self.$photoName)
                }
            }
            .navigationBarItems(trailing: Button("Done") {
                self.presentationMode.wrappedValue.dismiss()
            })
        }

    }
}

struct EditPhotoName_Previews: PreviewProvider {
    static var previews: some View {
        EditPhotoName(photoName: .constant(""))
            
    }
}
