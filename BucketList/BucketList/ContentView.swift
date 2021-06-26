//
//  ContentView.swift
//  BucketList
//
//  Created by Lorand Fazakas on 2021. 06. 21..
//

import SwiftUI
import MapKit
import LocalAuthentication

struct ContentView: View {
    @State private var isUnlocked = false
    @State private var showingAuthenticationAlert = false
    @State private var authenticationError =  ""
    
    var body: some View {
        ZStack {
            if isUnlocked {
                MainView()
            } else {
                Button("Unlock places") {
                    self.authenticate()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
        }
        .alert(isPresented: $showingAuthenticationAlert) {
            Alert(title: Text("Authentication was unsuccessfull"), message: Text(authenticationError), dismissButton: .default(Text("OK")))
        }
    }
    
    
    
    
    func authenticate() {
        let context =  LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock your places."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        self.authenticationError = "\(authenticationError?.localizedDescription ?? "Unknown error")"
                        self.showingAuthenticationAlert = true
                    }
                }
            }
        } else {
            self.authenticationError = "Biometric authentication is not available"
            self.showingAuthenticationAlert = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
