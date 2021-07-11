//
//  SettingsView.swift
//  Flashzilla
//
//  Created by Lorand Fazakas on 2021. 07. 11..
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var doRetryIncorrectCards: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Toggle(isOn: $doRetryIncorrectCards) {
                    Text("Do you want to retry incorrect cards?")
                }
                
            }
            .navigationBarTitle("Settings")
            .navigationBarItems(trailing: Button("Done", action: dismiss))
            
        }
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(doRetryIncorrectCards: .constant(false))
    }
}
