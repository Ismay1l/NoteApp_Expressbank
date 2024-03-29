//
//  SecondViewController.swift
//  Note_App
//
//  Created by Ismayil Ismayilov on 27.07.22.
//

import UIKit
import YPImagePicker

protocol SecondViewControllerDelegate {
    func saveNote()
}

class SecondViewController: UIViewController {
    
    //MARK: - Variables
    
    var delegate: SecondViewControllerDelegate?
    
    private var cameraClicked = true
    
    private let noteVM = NoteViewModel()
    
    //MARK: - UI Components
    
    lazy var headerTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Title"
        field.textColor = UIColor.init(named: "colorSet2")
        field.textAlignment = .center
        field.font = .systemFont(ofSize: 20, weight: .bold)
        field.delegate = self
        return field
    }()
    
    lazy var noteTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Your note"
        field.textColor = UIColor.init(named: "colorSet2")
        field.textAlignment = .left
        field.font = .systemFont(ofSize: 16, weight: .medium)
        field.delegate = self
        return field
    }()
    
    //MARK: - Parent Delegate
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if cameraClicked {
            self.headerTextField.text = ""
            self.noteTextField.text = ""
        }
        
        self.cameraClicked = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(named: "colorSet")
        
        configureConstraints()
        configureNavigationBarButtons()
    }
    
    //MARK: - Functions
    
    private func configureNavigationBarButtons() {
        
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
        
        self.navigationItem.rightBarButtonItems = [saveButton, addButton]
    }
    
    private func configureConstraints() {
        
        self.view.addSubview(self.headerTextField)
        self.view.addSubview(self.noteTextField)
        
        self.headerTextField.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(5)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(10)
        }
        
        self.noteTextField.snp.makeConstraints { make in
            make.top.equalTo(self.headerTextField.snp.bottom).offset(50)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(10)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-10)
        }
    }
    
    @objc func doneButtonTapped() {
        view.endEditing(true)
    }
    
    @objc func onSave() {
        self.cameraClicked = true
        if self.headerTextField.text != "" || self.noteTextField.text != "" {
            
            let alert = UIAlertController(title: "Success!",
                                          message: "Note saved",
                                          preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK",
                                         style: .default)
            alert.addAction(okButton)
            self.present(alert, animated: true) {
                self.noteVM.saveNote(title: self.headerTextField.text ?? "NS",
                                     body: self.noteTextField.text ?? "NS")
                
                self.delegate?.saveNote()
            }
            
        } else {
            let alert = UIAlertController(title: "Error!",
                                          message: "Please add note to save",
                                          preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK",
                                         style: .default)
            alert.addAction(okButton)
            self.present(alert, animated: true) {
               
            }
        }
    }
    
    @objc func onAdd() {
        self.headerTextField.text = ""
        self.noteTextField.text = ""
    }
}
