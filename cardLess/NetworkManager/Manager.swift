//
//  Manager.swift
//  cardLess
//
//  Created by Айбек on 30.07.2024.
//

import Foundation
import Firebase

class Manager {
    func registerNewUser(user: UserData, completion: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: user.email, password: user.pass) { res, err in
            guard err == nil else {
                completion(err)
                return
            }
            
            res?.user.sendEmailVerification { error in
                if let error = error {
                    completion(error)
                    return
                }
            }
            
            if let uid = res?.user.uid {
                Firestore.firestore()
                    .collection("users")
                    .document(uid)
                    .setData([
                        "email": user.email,
                        "isValid": false
                    ], merge: true) { err in
                        if let err = err {
                            completion(err)
                        } else {
                            completion(nil)
                        }
                    }
            } else {
                completion(nil)
            }
        }
    }
    
    func isUserRegistered(user: UserData, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: user.email, password: user.pass) { res, err in
            guard err == nil else {
                completion(err)
                return
            }
            completion(nil)
        }
    }
}

