//
//  HumidityMessage.swift
//  ROSTest
//
//  Created by Timofey Makeev on 20.04.17.
//  Copyright © 2017 dobro. All rights reserved.
//

import Foundation

public class HumidityMessage: ROSMessage {
    public var header: HeaderMessage = HeaderMessage()
    public var relativeHumidity: NSNumber = 0
    public var variance: NSNumber = 0
    
    override public func setDefaults() {
        self.header = HeaderMessage()
    }
}
