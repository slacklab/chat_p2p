//
//  ProfileViewController.swift
//  tChat
//
//  Created by z on 23/09/2018.
//  Copyright © 2018 Ivan Sorokoletov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //MARK: IBOutlets
    
    @IBOutlet weak var imgPlaceholderUser: UIImageView!
    @IBOutlet weak var buttonUploadProfilePhoto: UIButton!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descLabel: UILabel!
    
    @IBOutlet var buttonGCDProfile: UIButton!
    @IBOutlet var buttonOperationProfile: UIButton!
    @IBOutlet weak var buttonEditProfile: UIButton!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var descTextField: UITextField!
    
    //MARK: IBActions
    
    @IBAction func addPhotoButtonPressed(_ sender: UIButton) {
        handleTextFieldsNewData()

        print("Выбери изображение профиля")
        

        let chooseAlert = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet)

        chooseAlert.addAction(
            UIAlertAction(
                title: NSLocalizedString("Gallery", comment: ""),
                style: .default,
                handler: { [weak self] _ in
                    guard let strongSelf = self else { return }
                    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                        let imagePicker = UIImagePickerController()
                        imagePicker.delegate = strongSelf
                        imagePicker.sourceType = .photoLibrary;
                        imagePicker.allowsEditing = false
                        strongSelf.present(imagePicker, animated: true, completion: nil)
                    }
            }))

        chooseAlert.addAction(
            UIAlertAction(
                title: NSLocalizedString("Camera", comment: ""),
                style: .default) { [weak self] _ in
                    guard let strongSelf = self else { return }
                    if UIImagePickerController.isSourceTypeAvailable(.camera) {
                        let imagePicker = UIImagePickerController()
                        imagePicker.delegate = strongSelf
                        imagePicker.sourceType = .camera;
                        imagePicker.allowsEditing = false
                        strongSelf.present(imagePicker, animated: true, completion: nil)
                    }
        })

        chooseAlert.addAction(
            UIAlertAction(
                title: "Cancel",
                style: .cancel,
                handler: nil))

        self.present(chooseAlert, animated: true)
        
        
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func gcdBtnPressed(_ sender: Any) {
        handleTextFieldsNewData()
        saveProfileData(via: gcdProfileDataManager)
    }
    
    @IBAction func operationBtnPressed(_ sender: Any) {
        handleTextFieldsNewData()
        saveProfileData(via: operationProfileDataManager)
    }
    
    @IBAction func editBtnPressed(_ sender: Any) {
        isEditingContent = true
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
    
    private let gcdProfileDataManager = GCDProfileDataManager()
    private let operationProfileDataManager = OperationProfileDataManager()
    
    private(set) var isEditingContent: Bool = false {
        
        didSet {
            areSaveButtonsEnabled = false
            
            buttonEditProfile.isHidden = isEditingContent
            
            buttonOperationProfile.isHidden = !isEditingContent
            
            buttonGCDProfile.isHidden = !isEditingContent
            
            buttonUploadProfilePhoto.isHidden = !isEditingContent
            
            descTextField.isUserInteractionEnabled = isEditingContent
            descTextField.isHidden = !isEditingContent
            
            nameTextField.isUserInteractionEnabled = isEditingContent
            nameTextField.isHidden = !isEditingContent
            
            nameLabel.isHidden = isEditingContent
            
            descLabel.isHidden = isEditingContent
            
        }
    }
    
    private var profileData = ProfileData(name: nil, desc: nil, image: nil) {
        didSet {
            nameTextField.text = profileData.name
            descTextField.text = profileData.desc
            nameLabel.text = profileData.name
            descLabel.text = profileData.desc
            imgPlaceholderUser.image = profileData.image ?? UIImage(named: "placeholder-user")
        }
    }
    
    private var areSaveButtonsEnabled: Bool {
        get { return profileData.isModified }
        
        set(newValue) {
            buttonGCDProfile.isEnabled = newValue
            buttonOperationProfile.isEnabled = newValue
        }
    }
    

    

    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Logger.printViewLifeCycle(#function)
        // (16.0, 523.5, 288.0, 50.0) - при вызове метода viewDidLoad размеры frame'а берутся из StoryBoard
        print("Frame for Edit button from viewDidLoad = \(buttonEditProfile.frame)\n")
        
        
        isEditingContent = false
        
        nameTextField.delegate = self
        descTextField.delegate = self
        
        restoreProfileData(via: gcdProfileDataManager)
        
        activityIndicator.hidesWhenStopped = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Logger.printViewLifeCycle(#function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification,                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification,                                               object: nil)
        
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
        
        self.setUserInterface()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Logger.printViewLifeCycle(#function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        Logger.printViewLifeCycle(#function)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.descTextField.isFirstResponder || self.nameTextField.isFirstResponder {
            handleTextFieldsNewData()
        }
    }
    
    
    
    
    //MARK: Private Methods
    
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
        
        buttonGCDProfile.layer.borderWidth = 2
        buttonGCDProfile.layer.borderColor = UIColor.black.cgColor
        buttonGCDProfile.layer.cornerRadius = 15
        buttonGCDProfile.clipsToBounds = true
        
        buttonOperationProfile.layer.borderWidth = 2
        buttonOperationProfile.layer.borderColor = UIColor.black.cgColor
        buttonOperationProfile.layer.cornerRadius = 15
        buttonOperationProfile.clipsToBounds = true
    }
    
    
    private func saveProfileData(via manager: ProfileDataManager) {
        
        self.buttonGCDProfile.isUserInteractionEnabled = false
        self.buttonOperationProfile.isUserInteractionEnabled = false
        self.activityIndicator.startAnimating()
        
        manager.save(profileData: self.profileData) { [weak self] isSucceeded in
            if self != nil {
                self?.activityIndicator.stopAnimating()
                
                self?.isEditingContent = false
                
                self?.buttonGCDProfile.isUserInteractionEnabled = true
                self?.buttonOperationProfile.isUserInteractionEnabled = true
                
                if isSucceeded {
                    self?.sendSuccessSaveAlert()
                    self?.restoreProfileData(via: manager)
                } else {
                    self?.sendFailureSaveAlert(via: manager)
                }
            }
        }
    }
    
    private func restoreProfileData(via manager: ProfileDataManager) {
        self.activityIndicator.startAnimating()
        
        manager.loadProfileData { [weak self] profileData in
            if self != nil {
                self?.activityIndicator.stopAnimating()
                
                self?.profileData = profileData
            }
        }
    }
    
    private func sendSuccessSaveAlert() {
        
        let successAlert = UIAlertController(
            title: "Данные сохранены",
            message: nil,
            preferredStyle: .alert)
        
        successAlert.addAction(
            UIAlertAction(
                title: NSLocalizedString("Ok", comment: ""),
                style: .cancel))
        
        
        self.present(successAlert, animated: true)
    }
    
    private func sendFailureSaveAlert(via manager: ProfileDataManager) {
        
        let failureAlert = UIAlertController(
            title: "Ошибка",
            message: "Не удалось сохранить данные",
            preferredStyle: .alert)
        
        failureAlert.addAction(
            UIAlertAction(
                title: NSLocalizedString("Ok", comment: ""),
                style: .cancel))
        
        failureAlert.addAction(
            UIAlertAction(title: "Повторить",
                          style: .default) { action in
                            self.saveProfileData(via: manager)
        })
        
        self.present(failureAlert, animated: true)
    }
    
    private func sendEmptyNameWarningAlert() {
        let alert = UIAlertController(
            title: "Поле имени пустое",
            message: "Введите имя",
            preferredStyle: .alert)
        
        alert.addAction(
            UIAlertAction(
                title: NSLocalizedString("Ok", comment: ""),
                style: .cancel) { [weak self] _ in
                    self?.nameTextField.becomeFirstResponder()
        })
        
        self.present(alert, animated: true)
    }
    
    
    
    //MARK: Selectors
    
    @objc
    func keyboardWillShow(notification: NSNotification) {
        if self.view.frame.origin.y == 0,
            let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            let keyboardHeight = keyboardFrame.size.height
            self.view.frame = CGRect(x: self.view.frame.origin.x,
                                     y: self.view.frame.origin.y - keyboardHeight,
                                     width: self.view.frame.width,
                                     height: self.view.frame.height)
            self.view.layoutIfNeeded()
            
        }
    }
    
    @objc
    func keyboardWillHide(notification: NSNotification) {
        self.view.frame = CGRect(x: self.view.frame.origin.x,
                                 y: 0,
                                 width: self.view.frame.width,
                                 height: self.view.frame.height)
        self.view.layoutIfNeeded()
    }
    
    @objc
    private func dismissScreen() {
        dismiss(animated: true, completion: nil)
    }
    
}


extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            profileData.image = image
            imgPlaceholderUser.image = image
            dismiss(animated:true, completion: nil)
            
            areSaveButtonsEnabled = true
        }
    }
    
}

extension ProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleTextFieldsNewData()
        return true
    }
    
    private func handleTextFieldsNewData() {
        
        if profileData.name != nameTextField.text {
            
            if let text = nameTextField.text, text != "" {
                profileData.name = text
                
            } else {
                nameTextField.text = profileData.name
                
                self.view.endEditing(true)
                
                self.sendEmptyNameWarningAlert()
                return
            }
            
            areSaveButtonsEnabled = true
        }
        
        if profileData.desc != descTextField.text {
            profileData.desc = descTextField.text
            
            areSaveButtonsEnabled = true
        }
        
        self.view.endEditing(true)
    }
    
}


