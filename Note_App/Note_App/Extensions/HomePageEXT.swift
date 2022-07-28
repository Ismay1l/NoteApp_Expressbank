//
//  HomePageEXT.swift
//  Note_App
//
//  Created by Ismayil Ismayilov on 28.07.22.
//

import Foundation
import UIKit

extension HomeViewController: UITableViewDataSource,
                              UITableViewDelegate,
                              SecondViewControllerDelegate,
                              EditViewControllerDelegate {
    func saveNoteEdit() {
        vm.getAllNotes()
        noteTableView.reloadData()
    }
    
    func saveNote() {

        vm.getAllNotes()
        noteTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm.noteModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(MyTableViewCell.self)") as! MyTableViewCell

        cell.headerLabel.text = vm.noteModel[indexPath.row].title
        cell.noteLabel.text = vm.noteModel[indexPath.row].body
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        64
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let note = vm.noteModel[indexPath.row]
        if editingStyle == .delete {
            tableView.beginUpdates()
            vm.deleteNote(note: note)
            vm.noteModel.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath],
                                 with: .fade)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = vm.noteModel[indexPath.row]
        editVC.note = note
        editVC.headerTextField.text = vm.noteModel[indexPath.row].title
        editVC.noteTextField.text = vm.noteModel[indexPath.row].body
        self.navigationController?.pushViewController(editVC, animated: true)
    }
}
