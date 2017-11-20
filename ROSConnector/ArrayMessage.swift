//
//  ArrayMessage.swift
//  ROSTest
//
//  Created by Timofey Makeev on 25.05.17.
//  Copyright © 2017 dobro. All rights reserved.
//

import Foundation

public class ArrayMessage: ROSMessage {
    public var data = [Float64]()
    
    override public func setDefaults() {
        self.data = [Float64]()
    }
}
