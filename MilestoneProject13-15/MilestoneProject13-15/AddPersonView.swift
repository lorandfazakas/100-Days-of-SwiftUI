//
//  AddPersonView.swift
//  MilestoneProject13-15
//
//  Created by Lorand Fazakas on 2021. 06. 30..
//

import SwiftUI

struct AddPersonView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var persons: [Person]
    @State private var showingImagePicker = false
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var name = ""
    
    let locationFetcher = LocationFetcher()
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color.secondary)
                if image != nil {
                    image?
                        .resizable()
                        .scaledToFit()
                    
                } else {
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                }
            }
            .onTapGesture {
                showingImagePicker = true
            }
            Form {
                Section(header: Text("Enter the person's name")) {
                    TextField("Name", text: $name)
                }
                
                Button(action: savePerson) {
                    Text("Save")
                }
                .disabled(self.name.isEmpty || inputImage == nil)
            }
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
        .onAppear(perform: self.locationFetcher.start)
    }
    
    func loadImage() {
        guard let inputImage = self.inputImage else { return }
        self.image = Image(uiImage: inputImage)
    }
    
    func savePerson() {
        var person = Person(name: self.name)
        if let location = self.locationFetcher.lastKnownLocation {
            print("Your location is \(location)")
            person.longitude = location.longitude
            person.latitude = location.latitude
        } else {
            print("Your location is unknown")
        }
        
        if let jpegData = inputImage?.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: ImageUtil.getDocumentsDirectory().appendingPathComponent(person.imageURI), options: [.atomicWrite, .completeFileProtection])
        }
        persons.append(person)
        
        do {
            let filename = ImageUtil.getDocumentsDirectory().appendingPathComponent("Persons")
            let data = try JSONEncoder().encode(self.persons)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
        self.presentationMode.wrappedValue.dismiss()
    }
    
}

struct AddPersonView_Previews: PreviewProvider {
    static var previews: some View {
        AddPersonView(persons: .constant([Person]()))
    }
}
