//
//  EditPageEXT.swift
//  Note_App
//
//  Created by Ismayil Ismayilov on 28.07.22.
//

import Foundation
import UIKit

extension EditViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
