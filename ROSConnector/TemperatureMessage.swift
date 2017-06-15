//
//  TemperatureMessage.swift
//  ROSTest
//
//  Created by Timofey Makeev on 20.04.17.
//  Copyright © 2017 dobro. All rights reserved.
//

import Foundation

class TemperatureMessage: ROSMessage {
    var header: HeaderMessage = HeaderMessage()
    
    var temperature: Double = 0
    var variance: Double = 0
    
    override func setDefaults() {
        self.header = HeaderMessage()
    }
}
