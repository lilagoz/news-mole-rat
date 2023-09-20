//
//  LoginView.swift
//  NewsMoleRat
//
//  Created by Kiacz Gabor on 2023. 09. 19..
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct LoginView: View {
    @Environment(UserAuthModel.self) private var userAuth

    var body: some View {
        VStack{
            
            if !userAuth.isLoggedIn {
                GoogleSignInButton(
                    viewModel: GoogleSignInButtonViewModel(
                        scheme: GoogleSignInButtonColorScheme.light,
                        style: GoogleSignInButtonStyle.wide
                        
                    ),
                    action: {
                    userAuth.signIn()
                })
                .padding()
            } else {
                Text("Hellou, \(userAuth.givenName)")
                Image(uiImage: userAuth.profilePic)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150.0, height: 150.0)
                    .clipShape(RoundedRectangle(cornerRadius: 75))
                Text("You're logged in")
                Button("Sign out...") {
                    userAuth.signOut()
                }

            }
            Spacer()
        }.navigationTitle("Login")
    }
}

//#Preview {
//    LoginView()
//}
