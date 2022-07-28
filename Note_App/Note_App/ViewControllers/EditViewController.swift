//
//  EditViewController.swift
//  Note_App
//
//  Created by Ismayil Ismayilov on 28.07.22.
//

import UIKit

protocol EditViewControllerDelegate {
    func saveNoteEdit()
}

class EditViewController: UIViewController {
    
    //MARK: - Variables
    
    let noteVM = NoteViewModel()
    
    var note: Note?
    
    var newTitle: String?
    
    var newBody: String?
    
    var delegate: EditViewControllerDelegate?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(note: Note?) {
        self.note = note
        super.init(nibName: nil, bundle: nil)
    }
    
    
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
        
        self.navigationItem.rightBarButtonItems = [saveButton]
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
        
        newTitle = headerTextField.text
        newBody = noteTextField.text
        
            let alert = UIAlertController(title: "Success!",
                                          message: "Note change saved",
                                          preferredStyle: .alert)
        
            let okButton = UIAlertAction(title: "OK",
                                         style: .default)
        
            alert.addAction(okButton)
            self.present(alert, animated: true) {
                
                self.noteVM.updateNote(note: self.note ?? Note(),
                                       newTitle: self.newTitle ?? "",
                                       newBody: self.newBody ?? "")
                
                self.delegate?.saveNoteEdit()
            }
    }
}
