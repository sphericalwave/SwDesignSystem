//
//  Sequence+.swift
//  FitWrench
//
//  Created by Aaron McGrath on 2026-01-01.
//  Copyright © 2026 SphericalWaveSoftware. All rights reserved.
//

import Foundation

//FIXME: used in AbsMeal
public extension Sequence {
    func sum<T: AdditiveArithmetic>(of keyPath: KeyPath<Element, T>) -> T {
        reduce(.zero) { $0 + $1[keyPath: keyPath] }
    }
}
