//
//  DetailInterfaceController.swift
//  Project1 WatchKit Extension
//
//  Created by Cyril Garcia on 2/26/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import WatchKit
import Foundation


class DetailInterfaceController: WKInterfaceController {

    @IBOutlet var detailLabel: WKInterfaceLabel!
    @IBOutlet var noteCountLabel: WKInterfaceLabel!
    
    private var notes = [String]()
    private var index = 0
    var savePath = InterfaceController.getDocumentDirectory().appendingPathComponent("notes")

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if let noteContext = context as? Note {
            
            
            guard let index = noteContext.index else { return }
            guard let notes = noteContext.notes else { return }
            self.notes = notes
            self.index = index
            
            let note = notes[index]
            
            setTitle(note)
            detailLabel.setText(note)
            noteCountLabel.setText("\(index + 1)/\(notes.count)")
            
        }
        
        // Configure interface objects here.
    }
    
 
    @IBAction func editNote() {
        presentTextInputController(withSuggestions: ["Hi", "Hello"], allowedInputMode: .allowEmoji) { results in
            
            guard let result = results?.first as? String else { return }
            
            self.notes[self.index] = result
            self.detailLabel.setText(result)
            self.setTitle(result)
            self.update()
        }
    }
    
    @IBAction func deleteNote() {
        notes.remove(at: index)
        update()
        self.pop()
    }
    
    func update() {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: self.notes, requiringSecureCoding: false)
            
            try data.write(to: self.savePath)
        } catch {
            print("Failed to save data:", error.localizedDescription)
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
