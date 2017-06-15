//
//  WrenchMessage.swift
//  ROSTest
//
//  Created by Timofey Makeev on 20.04.17.
//  Copyright © 2017 dobro. All rights reserved.
//

import Foundation

public class WrenchMessage: ROSMessage {
    public var force: VectorMessage = VectorMessage()
    public var torque: VectorMessage = VectorMessage()
    
    override public func setDefaults() {
        self.force = VectorMessage()
        self.torque = VectorMessage()
    }
}
