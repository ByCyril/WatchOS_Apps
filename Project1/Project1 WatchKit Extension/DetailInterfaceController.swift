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
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        
        if let noteContext = context as? Note {
            
            guard let note = noteContext.note else { return }
            guard let id = noteContext.id else { return }
            guard let total = noteContext.total else { return }
            
            setTitle(note)
            detailLabel.setText(note)
            noteCountLabel.setText("\(id)/\(total)")
            
        }
        
        // Configure interface objects here.
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
