//
//  ProfileDataSaver.swift
//  tChat
//
//  Created by z on 21/10/2018.
//  Copyright © 2018 Ivan Sorokoletov. All rights reserved.
//

import Foundation

class SaveProfileDataOperation: Operation {

    var isSucceeded: Bool?

    let dataHandler = ProfileDataHandler()

    let profileData: ProfileData
    let completion: ((Bool) -> Void)?

    init(profileData: ProfileData, completion: ((Bool) -> Void)? ) {
        self.profileData = profileData
        self.completion = completion
    }

    override func main() {

        let isSucceeded = dataHandler.save(profileData: profileData)
        self.isSucceeded = isSucceeded
        completion?(isSucceeded)

    }
}
