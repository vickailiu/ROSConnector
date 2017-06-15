//
//  WrenchMessage.swift
//  ROSTest
//
//  Created by Timofey Makeev on 20.04.17.
//  Copyright © 2017 dobro. All rights reserved.
//

import Foundation

class WrenchMessage: ROSMessage {
    var force: VectorMessage = VectorMessage()
    var torque: VectorMessage = VectorMessage()
    
    override func setDefaults() {
        self.force = VectorMessage()
        self.torque = VectorMessage()
    }
}
