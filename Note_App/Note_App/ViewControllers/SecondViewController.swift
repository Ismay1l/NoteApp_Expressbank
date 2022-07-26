//
//  SecondViewController.swift
//  Note_App
//
//  Created by Ismayil Ismayilov on 27.07.22.
//

import UIKit
import YPImagePicker

protocol SecondViewControllerDelegate {
    func saveNote(header: String, note: String, image: UIImage?)
}

class SecondViewController: UIViewController {
    
    //MARK: - Variables
    
    var delegate: SecondViewControllerDelegate?
    
    var cameraClicked = true
    
    //MARK: - UI Components
    
    lazy var headerTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Header"
        field.textColor = .white
        field.textAlignment = .center
        field.font = .systemFont(ofSize: 20, weight: .bold)
        field.delegate = self
        return field
    }()
    
    lazy var noteTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Your note"
        field.textColor = .white
        field.textAlignment = .left
        field.font = .systemFont(ofSize: 16, weight: .medium)
        field.delegate = self
        return field
    }()
    
    lazy var image: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .black
        return iv
    }()
    
    //MARK: - Parent Delegate
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if cameraClicked {
            self.headerTextField.text = ""
            self.noteTextField.text = ""
            self.image.image = nil
        }
        
        self.cameraClicked = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        self.view.addSubview(self.headerTextField)
        self.view.addSubview(self.noteTextField)
        self.view.addSubview(image)
        
        self.getConstraints()
        
        let toolbar = UIToolbar()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done,
                                         target: self, action: #selector(doneButtonTapped))
        
        toolbar.setItems([doneButton], animated: true)
        toolbar.sizeToFit()
        
        headerTextField.inputAccessoryView = toolbar
        noteTextField.inputAccessoryView = toolbar
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save,
                                         target: self,
                                         action: #selector(onSave))
        
        saveButton.tintColor = .systemOrange
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .compose,
                                        target: self,
                                        action: #selector(onAdd))
        
        addButton.tintColor = .systemOrange
        
        let cameraButton = UIBarButtonItem(barButtonSystemItem: .camera,
                                           target: self,
                                           action: #selector(onCamera))
        
        cameraButton.tintColor = .systemOrange
        
        self.navigationItem.rightBarButtonItems = [saveButton, addButton, cameraButton]
    }
    
    //MARK: - Functions
    
    func getConstraints() {
        self.headerTextField.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(5)
            make.centerX.equalToSuperview()
        }
        
        self.noteTextField.snp.makeConstraints { make in
            make.top.equalTo(self.headerTextField.snp.bottom).offset(50)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(10)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-10)
        }
        
        self.image.snp.makeConstraints { make in
            make.top.equalTo(self.noteTextField.snp.bottom).offset(150)
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
            make.width.equalTo(self.image.snp.height).multipliedBy(1)
        }
    }
    
    @objc func doneButtonTapped() {
        view.endEditing(true)
    }
    
    @objc func onSave() {
        self.cameraClicked = true
        if self.headerTextField.text != "" || self.noteTextField.text != "" {
            
            self.delegate?.saveNote(header: self.headerTextField.text ?? "NA",
                                    note: self.noteTextField.text ?? "NA",
                                    image: self.image.image)
            
            let alert = UIAlertController(title: "Success!",
                                          message: "Note saved",
                                          preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK",
                                         style: .default)
            alert.addAction(okButton)
            self.present(alert, animated: true)
            
        } else {
            let alert = UIAlertController(title: "Error!",
                                          message: "Please add note to save",
                                          preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK",
                                         style: .default)
            alert.addAction(okButton)
            self.present(alert, animated: true)
        }
    }
    
    @objc func onAdd() {
        self.headerTextField.text = ""
        self.noteTextField.text = ""
    }
    
    @objc func onCamera() {
        self.cameraClicked = false
        var config = YPImagePickerConfiguration()
        config.screens = [.library, .photo]
        config.library.mediaType = .photo
        config.library.maxNumberOfItems = 1
        
        let picker = YPImagePicker(configuration: config)
        picker.didFinishPicking { items, cancelled in
            if cancelled {
                picker.dismiss(animated: true)
                return
            }
            
            if let photo = items.singlePhoto {
                self.image.image = photo.image
            }
            picker.dismiss(animated: true)
        }
        
        self.present(picker, animated: true)
    }
}

extension SecondViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
