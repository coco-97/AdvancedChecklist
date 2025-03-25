//
//  Checklist.swift
//  Checklists
//
//  Created by Sreyash Srivastava on 16/03/25.
//

import UIKit

class Checklist: NSObject, Codable {
    
    init(name: String){
        self.name = name
        super.init()
    }
    
    var name = ""
    var items = [ChecklistItem]()
}
