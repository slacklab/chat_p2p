//
//  ProfileDataManagerProtocol.swift
//  tChat
//
//  Created by z on 21/10/2018.
//  Copyright © 2018 Ivan Sorokoletov. All rights reserved.
//

import Foundation

protocol ProfileDataManager {
    func save(profileData: ProfileData, completion: ((Bool) -> Void)? )
    func loadProfileData(completion: ((ProfileData) -> Void)? )
}
