//
//  Profile+Extensions.swift
//  tChat
//
//  Created by z on 05/11/2018.
//  Copyright © 2018 Ivan Sorokoletov. All rights reserved.
//

import Foundation
import CoreData

extension Profile {
    @discardableResult

    static func insertOrUpdateProfile(in context: NSManagedObjectContext, name: String?, desc: String?, image: Data?) -> Profile? {

        let profiles = getProfilesList(in: context)
        assert(profiles.count <= 1, "Alone profile")
        //swiftlint:disable : force_cast
        let profile = profiles.first ?? NSEntityDescription.insertNewObject(forEntityName: "Profile", into: context) as! Profile
        //swiftlint:disable : force_cast

        profile.name = name
        profile.desc = desc
        profile.image = image

        return profile
    }

    static func getProfilesList(in context: NSManagedObjectContext) -> [Profile] {

        let templateName = "GetProfiles"

        guard let model = context.persistentStoreCoordinator?.managedObjectModel else {
            print(#function + " Have not ManagedObjectModel")
            return []
        }

        let fetchRequest = model.fetchRequestTemplate(forName: templateName) as! NSFetchRequest<Profile>

        do {
            let fetchResult = try context.fetch(fetchRequest)
            return fetchResult
        } catch {
            print(#function + " " + error.localizedDescription)
            return []
        }
    }
}
