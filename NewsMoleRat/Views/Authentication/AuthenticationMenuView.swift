//
//  AuthenticationMenuView.swift
//  NewsMoleRat
//
//  Created by Kiacz Gabor on 2023. 09. 25..
//

import SwiftUI

struct AuthenticationMenuView: View {
    @Environment(UserAuthModel.self) private var userAuth
    
    var body: some View {
        if(userAuth.isLoggedIn) {
            Menu {
                Button("Sign out") {
                    userAuth.signOut()
                }
                NavigationLink(destination: AdminListArticlesView()) {
                    Text("Admin")
                }
            } label: {
                Image(uiImage: userAuth.profilePic)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        } else {
            Menu {
                Button("Sign in...") {
                    userAuth.signIn()
                }
            } label: {
                Image(systemName: "person")
            }
        }
    }
}

#Preview {
    AuthenticationMenuView()
        .environment(UserAuthModel(isLoggedIn: true))
}
