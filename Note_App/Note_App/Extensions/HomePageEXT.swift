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
                              SecondViewControllerDelegate {
    
    func saveNote(header: String, note: String, image: UIImage?) {
        vm.headerLabel.append(header)
        vm.notesLabel.append(note)
        vm.images.append(image)
        myTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm.headerLabel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(MyTableViewCell.self)") as! MyTableViewCell
        cell.headerLabel.text = vm.headerLabel[indexPath.row]
        cell.noteLabel.text = vm.notesLabel[indexPath.row]
        cell.image.image = vm.images[indexPath.row]
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
            vm.headerLabel.remove(at: indexPath.row)
            vm.notesLabel.remove(at: indexPath.row)
            vm.images.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath],
                                 with: .fade)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(self.secondVC, animated: true)
        self.secondVC.headerTextField.text = vm.headerLabel[indexPath.row]
        self.secondVC.noteTextField.text = vm.notesLabel[indexPath.row]
        self.secondVC.image.image = vm.images[indexPath.row]
    }
}
