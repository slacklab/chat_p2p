//
//  CoreDataManager.swift
//  tChat
//
//  Created by z on 05/11/2018.
//  Copyright © 2018 Ivan Sorokoletov. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    let coreDataStack = CoreDataStack()
}


extension CoreDataManager: ProfileDataManager {
    
    func save(profileData: ProfileData, completion: ((Bool) -> ())?) {
        
        guard let saveContext = coreDataStack.saveContext else { return }
        
        saveContext.perform { [weak self] in
            Profile.insertOrUpdateProfile(in: saveContext, name: profileData.name, desc: profileData.desc, image: profileData.image?.jpegData(compressionQuality: 1))
            
            self?.coreDataStack.performSave(context: saveContext, completionHandler: { isSucceeded in
                DispatchQueue.main.async {
                    completion?(isSucceeded)
                }
            })
        }
        
    }
    
    func loadProfileData(completion: ((ProfileData) -> ())?) {
        
        var profileData: ProfileData? = nil
        if let mainContext = coreDataStack.mainContext {
            if let profile = Profile.getProfilesList(in: mainContext).first {
                let image = (profile.image == nil) ? nil : UIImage(data: profile.image!)
                profileData = ProfileData(name: profile.name,
                                          desc: profile.desc,
                                          image: image)
            }
        }
        
        completion?(profileData ?? ProfileData(name: nil, desc: nil, image: nil))
    }
}
