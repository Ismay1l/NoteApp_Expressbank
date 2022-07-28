//
//  NoteViewModel.swift
//  Note_App
//
//  Created by Ismayil Ismayilov on 28.07.22.
//

import Foundation
import UIKit

class NoteViewModel {
    
    var noteModel = [Note]()
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    private func saveContext() {
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func getAllNotes() {
        
        do {
            noteModel = try context.fetch(Note.fetchRequest())
        } catch {
            print(error)
        }
    }
    
    func saveNote(title: String, body: String) {
        let newNote = Note(context: context)
        newNote.title = title
        newNote.body = body
        
        saveContext()
    }
    
    func deleteNote(note: Note) {
        context.delete(note)
        
        saveContext()
    }
    
    func updateNote(note: Note, newTitle: String, newBody: String) {
        note.title = newTitle
        note.body = newBody
        
        saveContext()
    }
}
