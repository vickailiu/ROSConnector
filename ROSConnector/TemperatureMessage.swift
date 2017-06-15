//
//  TemperatureMessage.swift
//  ROSTest
//
//  Created by Timofey Makeev on 20.04.17.
//  Copyright © 2017 dobro. All rights reserved.
//

import Foundation

public class TemperatureMessage: ROSMessage {
    public var header: HeaderMessage = HeaderMessage()
    
    public var temperature: Double = 0
    public var variance: Double = 0
    
    override public func setDefaults() {
        self.header = HeaderMessage()
    }
}
