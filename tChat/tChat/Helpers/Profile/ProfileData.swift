//
//  ProfileData.swift
//  tChat
//
//  Created by z on 21/10/2018.
//  Copyright © 2018 Ivan Sorokoletov. All rights reserved.
//

import Foundation

class ProfileData {
    
    var name: String? {
        didSet {
            nameIsChanged = true
        }
    }
    
    var desc: String? {
        didSet {
            descIsChanged = true
        }
    }
    
    var image: UIImage? {
        didSet {
            imageIsChanged = true
        }
    }
    
    var isModified: Bool {
        return nameIsChanged || descIsChanged || imageIsChanged
    }
    
    private(set) var nameIsChanged: Bool = false
    private(set) var descIsChanged: Bool = false
    private(set) var imageIsChanged: Bool = false
    
    init(name: String?, desc: String?, image: UIImage?) {
        self.name = name
        self.desc = desc
        self.image = image
    }
}

