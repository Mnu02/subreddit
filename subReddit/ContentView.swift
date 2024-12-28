//
//  ContentView.swift
//  subReddit
//
//  Created by Mnumzana Franklin Moyo on 12/27/24.
//

import SwiftUI
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift
import FirebaseCore

struct ContentView: View {
    @State private var navigateToHomeView: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @EnvironmentObject var userSession: UserSession
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
                
                Button(action: {
                    signInWithGoogle()
                }) {
                    Text("Sign In With Google")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(.black)
                        .cornerRadius(10)
                }
                .frame(width: 300, height: 50)
                .padding()
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Sign-In Error"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            .navigationDestination(isPresented: $navigateToHomeView) {
                HomeView()
            }
        }
    }
    
    // MARK: - Google Sign-In
    private func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            self.alertMessage = "Missing aGoogle Client ID"
            self.showAlert = true
            return
        }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let presentingViewController = windowScene.windows.first?.rootViewController else {
            self.alertMessage = "Unable to find a valid presenting view controller"
            self.showAlert = true
            return
        }

        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { result, error in
            if let error = error {
                self.alertMessage = "Error signing in: \(error.localizedDescription)"
                self.showAlert = true
                return
            }

            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                self.alertMessage = "Error signing in: Unable to get user ID token"
                self.showAlert = true
                return
            }

            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: user.accessToken.tokenString
            )

            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    self.alertMessage = "Firebase sign-in error: \(error.localizedDescription)"
                    self.showAlert = true
                } else {
                    if let currentUser = Auth.auth().currentUser {
                        print("User is signed in: \(String(describing: Auth.auth().currentUser?.uid))")
                        userSession.userId = currentUser.uid
                        navigateToHomeView = true
                    } else {
                        self.alertMessage = "Sign-in succeeded, but no user found."
                        self.showAlert = true
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
