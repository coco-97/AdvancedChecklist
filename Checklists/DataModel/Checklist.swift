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
    var iconName = "No Icon"
    func countUncheckedItems() -> Int {
      var count = 0
      for item in items where !item.checked {
        count += 1
      }
      return count
    }
}
