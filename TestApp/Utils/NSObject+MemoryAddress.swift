//
//  NSObject+MemoryAddress.swift
//  TestApp
//
//  Created by Mohammed Al Waili on 19/02/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation

protocol MemoryAddressed: class {
    var memoryAddress: String { get }
}

extension MemoryAddressed {
    var memoryAddress: String {
        return "\(Unmanaged.passUnretained(self).toOpaque())"
    }
}

extension NSObject: MemoryAddressed { }
