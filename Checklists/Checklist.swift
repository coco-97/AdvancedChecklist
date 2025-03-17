//
//  Checklist.swift
//  Checklists
//
//  Created by Sreyash Srivastava on 16/03/25.
//

import UIKit

class Checklist: NSObject {
    
    init(name: String){
        self.name = name
        super.init()
    }
    
    var name = ""
}
