//
//  TwistMessage.swift
//  ROSTest
//
//  Created by Timofey Makeev on 20.04.17.
//  Copyright © 2017 dobro. All rights reserved.
//

import Foundation

class TwistMessage: ROSMessage {
    var linear: VectorMessage = VectorMessage()
    var angular: VectorMessage = VectorMessage()
    
    override func setDefaults() {
        self.linear = VectorMessage()
        self.angular = VectorMessage()
    }
    
}
