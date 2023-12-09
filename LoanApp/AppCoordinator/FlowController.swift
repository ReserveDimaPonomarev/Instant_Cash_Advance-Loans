//
//  FlowController.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 09.12.2023.
//

import Foundation

protocol FlowController {
    
    associatedtype T
    
    var complitionHandler: ((T) -> Void)? { get set }
}
