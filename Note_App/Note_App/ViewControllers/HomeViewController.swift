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
    
    let secondVC = SecondViewController()
    
    let idendifier = "my_cell"
    
    var isDeleteModeOn = false
    
    var headerLabel = [String]()
    
    var notesLabel = [String]()
    
    var images = [UIImage?]()
    
    //MARK: - UI Components
    
    private lazy var myTableView: UITableView = {
        let view = UITableView()
        
        view.register(MyTableViewCell.self,
                      forCellReuseIdentifier: idendifier)
        
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    //MARK: - Parents delegate

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        secondVC.delegate = self
        
        self.view.addSubview(self.myTableView)
        
        self.getConstraints()
        
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
    
    //MARK: - Functions
    
    @objc func onAdd() {
        self.navigationController?.pushViewController(self.secondVC, animated: true)
    }
    
    @objc func onEdit() {
        self.isDeleteModeOn.toggle()
        if self.isDeleteModeOn {
            self.myTableView.isEditing = true
        } else {
            self.myTableView.isEditing = false
        }
        
        self.myTableView.reloadData()
    }
    
    func getConstraints() {
        self.myTableView.snp.makeConstraints { make in
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(10)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-10)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
    }
}

//MARK: - Extension

extension HomeViewController: UITableViewDataSource,
                              UITableViewDelegate,
                              SecondViewControllerDelegate {
    
    func saveNote(header: String, note: String, image: UIImage?) {
        self.headerLabel.append(header)
        self.notesLabel.append(note)
        self.images.append(image)
        self.myTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.headerLabel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.idendifier) as! MyTableViewCell
        cell.headerLabel.text = self.headerLabel[indexPath.row]
        cell.noteLabel.text = self.notesLabel[indexPath.row]
        cell.image.image = self.images[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            self.headerLabel.remove(at: indexPath.row)
            self.notesLabel.remove(at: indexPath.row)
            self.images.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath],
                                 with: .fade)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(self.secondVC, animated: true)
        self.secondVC.headerTextField.text = self.headerLabel[indexPath.row]
        self.secondVC.noteTextField.text = self.notesLabel[indexPath.row]
        self.secondVC.image.image = self.images[indexPath.row]
    }
}
