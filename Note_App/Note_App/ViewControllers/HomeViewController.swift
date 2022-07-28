//
//  HomeViewController.swift
//  Note_App
//
//  Created by Ismayil Ismayilov on 27.07.22.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    //MARK: - Variables
    
    let vm = NoteViewModel()
    
    let secondVC = SecondViewController()
    
    let editVC = EditViewController(note: Note())
    
    let cell = MyTableViewCell()
   
    private var isDeleteModeOn = false
    
    //MARK: - UI Components
    
    lazy var noteTableView: UITableView = {
        let view = UITableView()
        
        view.register(MyTableViewCell.self,
                      forCellReuseIdentifier: "\(MyTableViewCell.self)")
        
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    //MARK: - Parents delegate

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(named: "colorSet")
        
        secondVC.delegate = self
        editVC.delegate = self
        
        configureConstraints()
        configureBarButtons()
        vm.getAllNotes()
        noteTableView.reloadData()
    }
    
    //MARK: - Functions
    
    private func configureBarButtons() {
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .compose,
                                        target: self,
                                        action: #selector(onAdd))
        
        addButton.tintColor = .systemOrange
        self.navigationItem.rightBarButtonItem = addButton
        
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit,
                                         target: self,
                                         action: #selector(onEdit))
        
        editButton.tintColor = .systemOrange
        self.navigationItem.leftBarButtonItem = editButton
        
        self.navigationController?.navigationBar.tintColor = UIColor.systemOrange
    }
    
    @objc func onAdd() {
        self.navigationController?.pushViewController(self.secondVC, animated: true)
    }
    
    @objc func onEdit() {
        self.isDeleteModeOn.toggle()
        if self.isDeleteModeOn {
            self.noteTableView.isEditing = true 
        } else {
            self.noteTableView.isEditing = false
        }
        
        self.noteTableView.reloadData()
    }
    
    private func configureConstraints() {
        
        self.view.addSubview(self.noteTableView)
        
        self.noteTableView.snp.makeConstraints { make in
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(10)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-10)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
    }
}
