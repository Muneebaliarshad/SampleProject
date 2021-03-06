//
//  UITableView.swift
//  BaseProject
//
//  Created by Muneeb Ali on 22/06/2020.
//  Copyright © 2020 Muneeb Ali. All rights reserved.
//

import UIKit

extension UITableView {
    
    func scrollToTop() {
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            self.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
    func scrollToBottom(){
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.numberOfRows(inSection:  self.numberOfSections-1), section:  self.numberOfSections-1)
            self.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    func scrollToSelectedRow(selectedRow: Int, selectedSection: Int) {
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: selectedRow, section: selectedSection)
            self.scrollToRow(at: indexPath, at: .none, animated: false)
        }
    }
}
