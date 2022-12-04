//
//  ErrorServerModel.swift
//  Marvel
//
//  Created by Daniel Personal on 3/12/22.
//

import Foundation

struct ErrorServerModel: BaseServerModel {
    let code: String?
    let status: String?
    let message: String?
}
