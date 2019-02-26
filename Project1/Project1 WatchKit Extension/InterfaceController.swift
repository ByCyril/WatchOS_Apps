//
//  InterfaceController.swift
//  Project1 WatchKit Extension
//
//  Created by Cyril Garcia on 2/25/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import WatchKit
import Foundation

let rowIdentifier = "row"

class InterfaceController: WKInterfaceController {

    @IBOutlet var table: WKInterfaceTable!
    
    var notes = [String]()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        table.setNumberOfRows(notes.count, withRowType: rowIdentifier)
        
        for row in 0..<notes.count {
            set(row, text: notes[row])
        }

    }
    
    func set (_ row: Int, text: String) {
        guard let row = table.rowController(at: row) as? NoteSelectRow else { return }
        row.textLabel.setText(text)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    @IBAction func addNewNote() {
        presentTextInputController(withSuggestions: nil, allowedInputMode: .plain) { results in
            
            guard let result = results?.first as? String else { return }
            self.table.insertRows(at: IndexSet(integer: self.notes.count), withRowType: rowIdentifier)
            self.set(self.notes.count, text: result)
            self.notes.append(result)
            
        }
    }
    
}
