//
//  CaseInterable.swift
//  Temptic
//
//  Created by Tinh Vu on 9/13/22.
//

import Foundation

extension CaseIterable where Self: Equatable {

    var index: Self.AllCases.Index? {
        return Self.allCases.firstIndex { self == $0 }
    }
}
