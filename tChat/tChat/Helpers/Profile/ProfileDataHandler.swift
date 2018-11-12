//
//  ProfileDataHandler.swift
//  tChat
//
//  Created by z on 21/10/2018.
//  Copyright © 2018 Ivan Sorokoletov. All rights reserved.
//

import Foundation

class ProfileDataHandler {

    private let defaults: UserDefaults
    private let suiteName = "ru.tChat.profile"
    private let nameKey = "name"
    private let descKey = "desc"
    private let imageFileName = "photo.png"
    private let storageDirectoryURL: URL

    init() {
        defaults = UserDefaults.init(suiteName: suiteName)!
        storageDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Profile", isDirectory: true)

        let directoryExists = FileManager.default.fileExists(atPath: storageDirectoryURL.path)

        if !directoryExists {
            try? FileManager.default.createDirectory(at: storageDirectoryURL, withIntermediateDirectories: false)
        }
    }

    func save(profileData: ProfileData) -> Bool {

        if profileData.nameIsChanged, let name = profileData.name {
            defaults.set(name, forKey: nameKey)
        }

        if profileData.descIsChanged, let desc = profileData.desc {
            defaults.set(desc, forKey: descKey)
        }

        if profileData.imageIsChanged, let image = profileData.image {
            guard let imageData = image.jpegData(compressionQuality: 1) else {
                return false

            }

            do {
                try imageData.write(to: storageDirectoryURL.appendingPathComponent(imageFileName, isDirectory: false).standardizedFileURL)
            } catch let error {
                print(error.localizedDescription)
                return false
            }
        }

        return true
    }

    func loadProfileData() -> ProfileData {
        let name = defaults.object(forKey: nameKey) as? String
        let desc = defaults.object(forKey: descKey) as? String
        let image = UIImage(contentsOfFile: storageDirectoryURL.appendingPathComponent(imageFileName, isDirectory: false).path)
        return ProfileData(name: name, desc: desc, image: image)
    }

}
