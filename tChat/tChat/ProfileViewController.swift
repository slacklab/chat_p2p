//
//  ProfileViewController.swift
//  tChat
//
//  Created by z on 23/09/2018.
//  Copyright © 2018 Ivan Sorokoletov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var imgPlaceholderUser: UIImageView!
    @IBOutlet weak var buttonUploadProfilePhoto: UIButton!
    
    @IBOutlet weak var buttonEditProfile: UIButton!
    
    @IBAction func addPhotoButtonPressed(_ sender: Any) {
        print("Выбери изображение профиля")
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //print("Frame for edit button from init = \(buttonEditProfile.frame)\n")
        
        /*
         Thread 1: Fatal error: Unexpectedly found nil while unwrapping an Optional value
         При init еще не загружаются обьекты StoryBoard, поэтому при unwrapping несуществующего
         свойства программа падает.
         */
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Logger.printViewLifeCycle(#function)
        
        self.setUserInterface()

        // (16.0, 523.5, 288.0, 50.0) - при вызове метода viewDidLoad размеры frame'а берутся из StoryBoard
        print("Frame for Edit button from viewDidLoad = \(buttonEditProfile.frame)\n")
        
    }
    
    private func setUserInterface() {
        // Rounded upload button for Profile Photo
        buttonUploadProfilePhoto.layer.cornerRadius = buttonUploadProfilePhoto.frame.size.width / 2
        buttonUploadProfilePhoto.clipsToBounds = true
        
        // Set placeholder for Profile image
        imgPlaceholderUser.layer.cornerRadius = buttonUploadProfilePhoto.frame.size.width / 2
        imgPlaceholderUser.clipsToBounds = true

        // Make corners for Edit button
        buttonEditProfile.layer.borderWidth = 2
        buttonEditProfile.layer.borderColor = UIColor.black.cgColor
        buttonEditProfile.layer.cornerRadius = 15
        buttonEditProfile.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Logger.printViewLifeCycle(#function)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Logger.printViewLifeCycle(#function)
        
//        Этот метод сработал после появления view на экране а также когда вычислены актуальные
//        размеры свойства frame после AutoLayout ( поэтому здесь frame отличается от значений из метода viewDidLoad )
        print("Frame for Edit button from viewDidAppear = \(buttonEditProfile.frame)\n")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        Logger.printViewLifeCycle(#function)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        Logger.printViewLifeCycle(#function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Logger.printViewLifeCycle(#function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        Logger.printViewLifeCycle(#function)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    
}

