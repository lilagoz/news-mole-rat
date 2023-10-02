//
//  UserAuthModel.swift
//  NewsMoleRat
//
//  Created by Kiacz Gabor on 2023. 09. 18..
//

import SwiftUI
import GoogleSignIn
import FirebaseCore
import FirebaseAuth


@Observable class UserAuthModel {
    var isLoggedIn: Bool = false
    var givenName: String = ""
    var profilePicUrl: String = ""
    var errorMessage: String = ""
    private var _profilePic: UIImage?
    
    var profilePic: UIImage {
        get {
            if _profilePic != nil {
                return self._profilePic!
            } else {
                return UIImage(systemName: "person")!
            }
        }
        set {
            _profilePic = newValue
        }
    }
    
    init(){
    }
    init(isLoggedIn: Bool) {
        self.isLoggedIn = isLoggedIn
    }
    
    private func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            if let uiImage = UIImage(data: data) {
                completion(uiImage)
            } else {
                completion(nil)
            }
        }.resume()
    }
    
    func checkStatus(){
        if(GIDSignIn.sharedInstance.currentUser != nil && Auth.auth().currentUser != nil ){
            let user = GIDSignIn.sharedInstance.currentUser
            guard let user = user else { return }
            let givenName = user.profile?.givenName
            let profilePicUrl = user.profile!.imageURL(withDimension: 100)!.absoluteString
            if self._profilePic == nil {
                downloadImage(from: profilePicUrl) { uiImage in
                    guard let uiImage = uiImage else {
                        print("Failed to download the image.")
                        return
                    }
                    self._profilePic = uiImage
                }
            } else {
                self._profilePic = nil
            }
            self.givenName = givenName ?? ""
            self.profilePicUrl = profilePicUrl
            self.isLoggedIn = true
        }else{
            self.isLoggedIn = false
            self.givenName = "Not Logged In"
            self.profilePicUrl =  ""
            self._profilePic = nil
        }
    }
    
    private func afterLogin (user: GIDGoogleUser) {
        if let idToken = user.idToken?.tokenString {
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            Auth.auth().signIn(with: credential) { result, error in
                guard error == nil else {
                    print("authauth failed \(String(describing: error?.localizedDescription))")
                    return
                }
                self.checkStatus()
            }
        }
    }
    
    func check(){
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if let user = user {
                print("user: \(String(describing: user))")
                self.afterLogin(user: user)
            }
            else if let error = error {
                self.errorMessage = error.localizedDescription
                print("error \(String(describing: error))")
            }
        }
    }
    
    func signIn(){
        print("sign in")
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}

        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { signInResult, error in
            guard error == nil, let user = signInResult?.user else {
                print("sign in error \(String(describing: error?.localizedDescription))")
                return
            }
            
            self.afterLogin(user: user)
        }
        
    }
    
    func signOut(){
        print("sign out")
        GIDSignIn.sharedInstance.signOut()
        self.checkStatus()
        print("signed out")
    }
}
