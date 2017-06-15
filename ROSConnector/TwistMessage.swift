//
//  TwistMessage.swift
//  ROSTest
//
//  Created by Timofey Makeev on 20.04.17.
//  Copyright © 2017 dobro. All rights reserved.
//

import Foundation

public class TwistMessage: ROSMessage {
    public var linear: VectorMessage = VectorMessage()
    public var angular: VectorMessage = VectorMessage()
    
    override public func setDefaults() {
        self.linear = VectorMessage()
        self.angular = VectorMessage()
    }
    
}
