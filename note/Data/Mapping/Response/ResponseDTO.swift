//
//  ResponseDTO.swift
//  note
//
//

import Foundation


protocol DomainConvertible {
    associatedtype T
    func toDomain() -> T
}
