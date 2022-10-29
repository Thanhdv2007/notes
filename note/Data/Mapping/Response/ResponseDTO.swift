//
//  ResponseDTO.swift
//  note
//
//  Created by Thanh on 28/10/2022.
//

import Foundation


protocol DomainConvertible {
    associatedtype T
    func toDomain() -> T
}
