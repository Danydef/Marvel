//
//  CustomErrorAlertAction.swift
//  Marvel
//
//  Created by Daniel Personal on 3/12/22.
//

import Foundation

struct CustomAlertAction {
    
    var title: String
    var handler: ((CustomAlertAction) -> Void)?
    
    init(title: String,
         handler: ((CustomAlertAction) -> Void)? = nil) {
        
        self.title = title
        self.handler = handler
    }
}

